package syncer

import (
	"context"
	"errors"
	"fmt"
	"net/url"
	"strings"
	"time"

	"github.com/jackc/pgx/v4"
	"github.com/mergestat/fuse/internal/db"
	uuid "github.com/satori/go.uuid"
)

const selectGitHubPRReviews = `SELECT github_prs.number AS pr_number, github_pr_reviews.* FROM github_prs(?), github_pr_reviews(?, github_prs.number)`

type githubPRReview struct {
	PRNumber                  *int       `db:"pr_number"`
	ID                        *string    `db:"id"`
	AuthorLogin               *string    `db:"author_login"`
	AuthorURL                 *string    `db:"author_url"`
	AuthorAssociation         *string    `db:"author_association"`
	AuthorCanPushToRepository *bool      `db:"author_can_push_to_repository"`
	Body                      *string    `db:"body"`
	CommentCount              *int       `db:"comment_count"`
	CreatedAt                 *time.Time `db:"created_at"`
	CreatedViaEmail           *bool      `db:"created_via_email"`
	EditorLogin               *string    `db:"editor_login"`
	LastEditedAt              *time.Time `db:"last_edited_at"`
	PublishedAt               *time.Time `db:"published_at"`
	State                     *string    `db:"state"`
	SubmittedAt               *time.Time `db:"submitted_at"`
	UpdatedAt                 *time.Time `db:"updated_at"`
}

// sendBatchGitHubPRReviews uses the pg COPY protocol to send a batch of GitHub pr reviews
func (w *worker) sendBatchGitHubPRReviews(ctx context.Context, tx pgx.Tx, j *db.DequeueSyncJobRow, batch []*githubPRReview) error {
	cols := []string{
		"repo_id",
		"pr_number",
		"id",
		"author_login",
		"author_url",
		"author_association",
		"author_can_push_to_repository",
		"body",
		"comment_count",
		"created_at",
		"created_via_email",
		"editor_login",
		"last_edited_at",
		"published_at",
		"state",
		"submitted_at",
		"updated_at",
	}

	inputs := make([][]interface{}, 0, len(batch))
	for _, r := range batch {
		var repoID uuid.UUID
		var err error
		if repoID, err = uuid.FromString(j.RepoID.String()); err != nil {
			return err
		}

		input := []interface{}{repoID, r.PRNumber, r.ID, r.AuthorLogin, r.AuthorURL, r.AuthorAssociation, r.AuthorCanPushToRepository, r.Body,
			r.CommentCount, r.CreatedAt, r.CreatedViaEmail, r.EditorLogin, r.LastEditedAt, r.PublishedAt, r.State, r.SubmittedAt, r.UpdatedAt,
		}
		inputs = append(inputs, input)
	}

	if _, err := tx.CopyFrom(ctx, pgx.Identifier{"github_pull_request_reviews"}, cols, pgx.CopyFromRows(inputs)); err != nil {
		return err
	}
	return nil
}

func (w *worker) handleGitHubPRReviews(ctx context.Context, j *db.DequeueSyncJobRow) error {
	l := w.loggerForJob(j)

	// indicate that we're starting query execution
	if err := w.sendBatchLogMessages(ctx, []*syncLog{
		{Type: SyncLogTypeInfo, RepoSyncQueueID: j.ID, Message: "starting to execute GitHub PR reviews lookup query"},
	}); err != nil {
		return err
	}

	var u *url.URL
	var err error
	if u, err = url.Parse(j.Repo); err != nil {
		return fmt.Errorf("could not parse repo: %v", err)
	}

	components := strings.Split(u.Path, "/")
	repoOwner := components[1]
	repoName := components[2]
	repoFullName := fmt.Sprintf("%s/%s", repoOwner, repoName)

	reviews := make([]*githubPRReview, 0)
	if err := w.mergestat.SelectContext(ctx, &reviews, selectGitHubPRReviews, repoFullName, repoFullName); err != nil {
		return err
	}

	l.Info().Msgf("retrieved PR reviews: %d", len(reviews))

	var tx pgx.Tx
	if tx, err = w.pool.BeginTx(ctx, pgx.TxOptions{}); err != nil {
		return err
	}
	defer func() {
		if err := tx.Rollback(ctx); err != nil {
			if !errors.Is(err, pgx.ErrTxClosed) {
				w.logger.Err(err).Msgf("could not rollback transaction")
			}
		}
	}()

	if _, err := tx.Exec(ctx, "DELETE FROM github_pull_request_reviews WHERE repo_id = $1;", j.RepoID.String()); err != nil {
		return err
	}

	if err := w.sendBatchGitHubPRReviews(ctx, tx, j, reviews); err != nil {
		return err
	}

	if err := w.db.WithTx(tx).SetSyncJobStatus(ctx, db.SetSyncJobStatusParams{Status: "DONE", ID: j.ID}); err != nil {
		return err
	}

	return tx.Commit(ctx)
}
