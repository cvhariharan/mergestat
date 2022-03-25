// Code generated by sqlc. DO NOT EDIT.

package db

import (
	"database/sql"
	"time"

	"github.com/google/uuid"
	"github.com/jackc/pgtype"
)

type GitBranch struct {
	RepoID        uuid.UUID
	FullName      string
	Hash          sql.NullString
	Name          sql.NullString
	Remote        sql.NullString
	Target        sql.NullString
	Type          sql.NullString
	TagCommitHash sql.NullString
}

// Git repository commits
type GitCommit struct {
	RepoID         uuid.UUID
	Hash           string
	Message        string
	AuthorName     string
	AuthorEmail    string
	AuthorWhen     time.Time
	CommitterName  string
	CommitterEmail string
	CommitterWhen  time.Time
	Parents        int32
}

// Commit stats
type GitCommitStat struct {
	RepoID     uuid.UUID
	CommitHash string
	FilePath   string
	Additions  int32
	Deletions  int32
}

// Refs for a Git repo
type GitRef struct {
	RepoID        uuid.UUID
	FullName      string
	Hash          sql.NullString
	Name          sql.NullString
	Remote        sql.NullString
	Target        sql.NullString
	Type          sql.NullString
	TagCommitHash sql.NullString
}

type GitTag struct {
	RepoID        uuid.UUID
	FullName      string
	Hash          sql.NullString
	Name          sql.NullString
	Remote        sql.NullString
	Target        sql.NullString
	Type          sql.NullString
	TagCommitHash sql.NullString
}

// GitHub issues
type GithubIssue struct {
	RepoID              uuid.UUID
	AuthorLogin         sql.NullString
	Body                sql.NullString
	Closed              sql.NullBool
	ClosedAt            sql.NullTime
	CommentCount        sql.NullInt32
	CreatedAt           sql.NullTime
	CreatedViaEmail     sql.NullBool
	DatabaseID          int32
	EditorLogin         sql.NullString
	IncludesCreatedEdit sql.NullBool
	LabelCount          sql.NullInt32
	LastEditedAt        sql.NullTime
	Locked              sql.NullBool
	MilestoneCount      sql.NullInt32
	Number              int32
	ParticipantCount    sql.NullInt32
	PublishedAt         sql.NullTime
	ReactionCount       sql.NullInt32
	State               sql.NullString
	Title               sql.NullString
	UpdatedAt           sql.NullTime
	Url                 sql.NullString
}

// GitHub pull requests
type GithubPullRequest struct {
	RepoID              uuid.UUID
	Additions           sql.NullInt32
	AuthorLogin         sql.NullString
	AuthorAssociation   sql.NullString
	AuthorAvatarUrl     sql.NullString
	AuthorName          sql.NullString
	BaseRefOid          sql.NullString
	BaseRefName         sql.NullString
	BaseRepositoryName  sql.NullString
	Body                sql.NullString
	ChangedFiles        sql.NullInt32
	Closed              sql.NullBool
	ClosedAt            sql.NullTime
	CommentCount        sql.NullInt32
	CommitCount         sql.NullInt32
	CreatedAt           sql.NullTime
	CreatedViaEmail     sql.NullBool
	DatabaseID          int32
	Deletions           sql.NullInt32
	EditorLogin         sql.NullString
	HeadRefName         sql.NullString
	HeadRefOid          sql.NullString
	HeadRepositoryName  sql.NullString
	IsDraft             sql.NullBool
	LabelCount          sql.NullInt32
	LastEditedAt        sql.NullTime
	Locked              sql.NullBool
	MaintainerCanModify sql.NullBool
	MantainerCanModify  sql.NullBool
	Mergeable           sql.NullString
	Merged              sql.NullBool
	MergedAt            sql.NullTime
	MergedBy            sql.NullString
	Number              sql.NullInt32
	ParticipantCount    sql.NullInt32
	PublishedAt         sql.NullTime
	ReviewDecision      sql.NullString
	State               sql.NullString
	Title               sql.NullString
	UpdatedAt           sql.NullTime
	Url                 sql.NullString
}

// GitHub metadata about a repo
type GithubRepoInfo struct {
	RepoID                   uuid.UUID
	Owner                    string
	Name                     string
	CreatedAt                sql.NullTime
	DefaultBranchName        sql.NullString
	Description              sql.NullString
	DiskUsage                sql.NullInt32
	ForkCount                sql.NullInt32
	HomepageUrl              sql.NullString
	IsArchived               sql.NullBool
	IsDisabled               sql.NullBool
	IsMirror                 sql.NullBool
	IsPrivate                sql.NullBool
	TotalIssuesCount         sql.NullInt32
	LatestReleaseAuthor      sql.NullString
	LatestReleaseCreatedAt   sql.NullTime
	LatestReleaseName        sql.NullString
	LatestReleasePublishedAt sql.NullTime
	LicenseKey               sql.NullString
	LicenseName              sql.NullString
	LicenseNickname          sql.NullString
	OpenGraphImageUrl        sql.NullString
	PrimaryLanguage          sql.NullString
	PushedAt                 sql.NullTime
	ReleasesCount            sql.NullInt32
	StargazersCount          sql.NullInt32
	UpdatedAt                sql.NullTime
	WatchersCount            sql.NullInt32
}

// GitHub stargazers for a repo
type GithubStargazer struct {
	RepoID    uuid.UUID
	Login     string
	Email     sql.NullString
	Name      sql.NullString
	Bio       sql.NullString
	Company   sql.NullString
	AvatarUrl sql.NullString
	CreatedAt sql.NullTime
	UpdatedAt sql.NullTime
	Twitter   sql.NullString
	Website   sql.NullString
	Location  sql.NullString
	StarredAt sql.NullTime
}

type MergestatLatestRepoSync struct {
	ID         int64
	CreatedAt  time.Time
	RepoSyncID uuid.UUID
	Status     string
	StartedAt  sql.NullTime
	DoneAt     sql.NullTime
}

// Table for "dynamic" repo imports - regularly loading from a GitHub org for example
type MergestatRepoImport struct {
	ID                  uuid.UUID
	CreatedAt           time.Time
	UpdatedAt           time.Time
	Type                string
	Settings            pgtype.JSONB
	LastImport          sql.NullTime
	ImportInterval      sql.NullString
	LastImportStartedAt sql.NullTime
}

// Types of repo imports
type MergestatRepoImportType struct {
	Type        string
	Description string
}

type MergestatRepoSync struct {
	RepoID   uuid.UUID
	SyncType string
	Settings pgtype.JSONB
	ID       uuid.UUID
}

type MergestatRepoSyncLog struct {
	ID              int64
	CreatedAt       time.Time
	LogType         string
	Message         string
	RepoSyncQueueID int64
}

type MergestatRepoSyncLogType struct {
	Type        string
	Description sql.NullString
}

type MergestatRepoSyncQueue struct {
	ID            int64
	CreatedAt     time.Time
	RepoSyncID    uuid.UUID
	Status        string
	StartedAt     sql.NullTime
	DoneAt        sql.NullTime
	LastKeepAlive sql.NullTime
}

type MergestatRepoSyncQueueStatusType struct {
	Type        string
	Description sql.NullString
}

type MergestatRepoSyncType struct {
	Type        string
	Description sql.NullString
}

// Git repositories to track
type Repo struct {
	ID           uuid.UUID
	Repo         string
	Ref          sql.NullString
	IsGithub     sql.NullBool
	CreatedAt    time.Time
	Settings     pgtype.JSONB
	Tags         pgtype.JSONB
	RepoImportID uuid.NullUUID
}
