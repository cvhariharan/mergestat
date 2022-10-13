BEGIN;

COMMENT ON TABLE public.git_blame IS 'git blame of all lines in all files of a repo';
COMMENT ON COLUMN public.git_blame.repo_id IS 'foreign key for public.repos.id';
COMMENT ON COLUMN public.git_blame.author_email IS 'email of the author who modified the line';
COMMENT ON COLUMN public.git_blame.author_name IS 'name of the author who modified the line';
COMMENT ON COLUMN public.git_blame.commit_hash IS 'hash of the commit the modification was made in';
COMMENT ON COLUMN public.git_blame.line_no IS 'line number of the modification';
COMMENT ON COLUMN public.git_blame.path IS 'path of the file the modification was made in';
COMMENT ON COLUMN public.git_blame._mergestat_synced_at IS 'timestamp when record was synced into the MergeStat database';

COMMENT ON TABLE public.git_commit_stats IS 'git commit stats of a repo';
COMMENT ON COLUMN public.git_commit_stats.repo_id IS 'foreign key for public.repos.id';
COMMENT ON COLUMN public.git_commit_stats.commit_hash IS 'hash of the commit';
COMMENT ON COLUMN public.git_commit_stats.file_path IS 'path of the file the modification was made in';
COMMENT ON COLUMN public.git_commit_stats.additions IS 'the number of additions in this path of the commit';
COMMENT ON COLUMN public.git_commit_stats.deletions IS 'the number of deletions in this path of the commit';
COMMENT ON COLUMN public.git_commit_stats.old_file_mode IS 'old file mode derived from git mode. possible values (unknown, none, regular_file, symbolic_link, git_link)';
COMMENT ON COLUMN public.git_commit_stats.new_file_mode IS 'new file mode derived from git mode. possible values (unknown, none, regular_file, symbolic_link, git_link)';
COMMENT ON COLUMN public.git_commit_stats._mergestat_synced_at IS 'timestamp when record was synced into the MergeStat database';

COMMENT ON TABLE public.git_commits IS 'git commit history of a repo';
COMMENT ON COLUMN public.git_commits.repo_id IS 'foreign key for public.repos.id';
COMMENT ON COLUMN public.git_commits.hash IS 'hash of the commit';
COMMENT ON COLUMN public.git_commits.message IS 'message of the commit';
COMMENT ON COLUMN public.git_commits.author_email IS 'email of the author of the modification';
COMMENT ON COLUMN public.git_commits.author_name IS 'name of the author of the the modification';
COMMENT ON COLUMN public.git_commits.author_when IS 'timestamp of when the modifcation was authored';
COMMENT ON COLUMN public.git_commits.committer_email IS 'email of the author who committed the modification';
COMMENT ON COLUMN public.git_commits.committer_name IS 'name of the author who committed the modification';
COMMENT ON COLUMN public.git_commits.committer_when IS 'timestamp of when the commit was made';
COMMENT ON COLUMN public.git_commits.parents IS 'the number of parents of the commit';
COMMENT ON COLUMN public.git_commits._mergestat_synced_at IS 'timestamp when record was synced into the MergeStat database';

COMMENT ON TABLE public.git_files IS 'git files (content and paths) of a repo';
COMMENT ON COLUMN public.git_files.repo_id IS 'foreign key for public.repos.id';
COMMENT ON COLUMN public.git_files.path IS 'path of the file';
COMMENT ON COLUMN public.git_files.executable IS 'boolean to determine if the file is an executable';
COMMENT ON COLUMN public.git_files.contents IS 'contents of the file';
COMMENT ON COLUMN public.git_files._mergestat_synced_at IS 'timestamp when record was synced into the MergeStat database';

COMMENT ON TABLE public.git_refs IS 'git refs of a repo';
COMMENT ON COLUMN public.git_refs.repo_id IS 'foreign key for public.repos.id';
COMMENT ON COLUMN public.git_refs.hash IS 'hash of the commit for refs that are not of type tag';
COMMENT ON COLUMN public.git_refs.name IS 'name of the ref';
COMMENT ON COLUMN public.git_refs.remote IS 'remote of the ref';
COMMENT ON COLUMN public.git_refs.target IS 'target of the ref';
COMMENT ON COLUMN public.git_refs.type IS 'type of the ref';
COMMENT ON COLUMN public.git_refs.tag_commit_hash IS 'hash of the commit for refs that are of type tag';
COMMENT ON COLUMN public.git_refs._mergestat_synced_at IS 'timestamp when record was synced into the MergeStat database';

COMMENT ON view public.git_branches IS 'view of git refs of type branch of a repo';
COMMENT ON COLUMN public.git_branches.repo_id IS 'foreign key for public.repos.id';
COMMENT ON COLUMN public.git_branches.hash IS 'hash of the commit for refs that are not of type tag';
COMMENT ON COLUMN public.git_branches.name IS 'name of the ref';
COMMENT ON COLUMN public.git_branches.remote IS 'remote of the ref';
COMMENT ON COLUMN public.git_branches.target IS 'target of the ref';
COMMENT ON COLUMN public.git_branches.type IS 'type of the ref';
COMMENT ON COLUMN public.git_branches.tag_commit_hash IS 'hash of the commit for refs that are of type tag';
COMMENT ON COLUMN public.git_branches._mergestat_synced_at IS 'timestamp when record was synced into the MergeStat database';

COMMENT ON view public.git_tags IS 'view of git refs of type tag of a repo';
COMMENT ON COLUMN public.git_tags.repo_id IS 'foreign key for public.repos.id';
COMMENT ON COLUMN public.git_tags.hash IS 'hash of the ref that are of type tag';
COMMENT ON COLUMN public.git_tags.name IS 'name of the ref';
COMMENT ON COLUMN public.git_tags.remote IS 'remote of the ref';
COMMENT ON COLUMN public.git_tags.target IS 'target of the ref';
COMMENT ON COLUMN public.git_tags.type IS 'type of the ref';
COMMENT ON COLUMN public.git_tags.tag_commit_hash IS 'hash of the commit for refs that are of type tag';
COMMENT ON COLUMN public.git_tags._mergestat_synced_at IS 'timestamp when record was synced into the MergeStat database';

COMMENT ON TABLE public.github_issues IS 'issues of a GitHub repo';
COMMENT ON COLUMN public.github_issues.repo_id IS 'foreign key for public.repos.id';
COMMENT ON COLUMN public.github_issues.author_login IS 'login of the author of the issue';
COMMENT ON COLUMN public.github_issues.body IS 'body of the issue';
COMMENT ON COLUMN public.github_issues.closed IS 'boolean to determine if the issue is closed';
COMMENT ON COLUMN public.github_issues.closed_at IS 'timestamp of when the issue was closed';
COMMENT ON COLUMN public.github_issues.created_via_email IS 'boolean to determine if the issue was created via email';
COMMENT ON COLUMN public.github_issues.database_id IS 'GitHub database_id of the issue';
COMMENT ON COLUMN public.github_issues.editor_login IS 'login of the editor of the issue';
COMMENT ON COLUMN public.github_issues.includes_created_edit IS 'boolean to determine if the issue was edited and includes an edit with the creation data';
COMMENT ON COLUMN public.github_issues.label_count IS 'number of labels associated to the issue';
COMMENT ON COLUMN public.github_issues.last_edited_at IS 'timestamp when the issue was edited';
COMMENT ON COLUMN public.github_issues.locked IS 'boolean to determine if the issue is locked';
COMMENT ON COLUMN public.github_issues.milestone_count IS 'number of milestones associated to the issue';
COMMENT ON COLUMN public.github_issues.number IS 'GitHub number for the issue';
COMMENT ON COLUMN public.github_issues.participant_count IS 'number of participants associated to the issue';
COMMENT ON COLUMN public.github_issues.published_at IS 'timestamp when the issue was published';
COMMENT ON COLUMN public.github_issues.reaction_count IS 'number of reactions associated to the issue';
COMMENT ON COLUMN public.github_issues.state IS 'state of the issue';
COMMENT ON COLUMN public.github_issues.title IS 'title of the issue';
COMMENT ON COLUMN public.github_issues.updated_at IS 'timestamp when the issue was updated';
COMMENT ON COLUMN public.github_issues.url IS 'GitHub URL of the issue';
COMMENT ON COLUMN public.github_issues.labels IS 'labels associated to the issue';
COMMENT ON COLUMN public.github_issues._mergestat_synced_at IS 'timestamp when record was synced into the MergeStat database';

COMMENT ON TABLE public.github_pull_request_commits IS 'commits for all pull requests of a GitHub repo';
COMMENT ON COLUMN public.github_pull_request_commits.repo_id IS 'foreign key for public.repos.id';
COMMENT ON COLUMN public.github_pull_request_commits.pr_number IS 'GitHub pull request number of the commit';
COMMENT ON COLUMN public.github_pull_request_commits.hash IS 'hash of the commit';
COMMENT ON COLUMN public.github_pull_request_commits.message IS 'message of the commit';
COMMENT ON COLUMN public.github_pull_request_commits.author_email IS 'email of the author of the modification';
COMMENT ON COLUMN public.github_pull_request_commits.author_name IS 'name of the author of the the modification';
COMMENT ON COLUMN public.github_pull_request_commits.author_when IS 'timestamp of when the modifcation was authored';
COMMENT ON COLUMN public.github_pull_request_commits.committer_email IS 'email of the author who committed the modification';
COMMENT ON COLUMN public.github_pull_request_commits.committer_name IS 'name of the author who committed the modification';
COMMENT ON COLUMN public.github_pull_request_commits.committer_when IS 'timestamp of when the commit was made';
COMMENT ON COLUMN public.github_pull_request_commits.additions IS 'the number of additions in the commit';
COMMENT ON COLUMN public.github_pull_request_commits.deletions IS 'the number of deletions in the commit';
COMMENT ON COLUMN public.github_pull_request_commits.changed_files IS 'the number of files changed/modified in the commit';
COMMENT ON COLUMN public.github_pull_request_commits.url IS 'GitHub URL of the commit';
COMMENT ON COLUMN public.github_pull_request_commits._mergestat_synced_at IS 'timestamp when record was synced into the MergeStat database';

COMMENT ON TABLE public.github_pull_request_reviews IS 'reviews for all pull requests of a GitHub repo';
COMMENT ON COLUMN public.github_pull_request_reviews.repo_id IS 'foreign key for public.repos.id';
COMMENT ON COLUMN public.github_pull_request_reviews.pr_number IS 'GitHub pull request number of the review';
COMMENT ON COLUMN public.github_pull_request_reviews.id IS 'GitHub id of the review';
COMMENT ON COLUMN public.github_pull_request_reviews.author_login IS 'login of the author of the review';
COMMENT ON COLUMN public.github_pull_request_reviews.author_url IS 'URL to the profile of the author of the review';
COMMENT ON COLUMN public.github_pull_request_reviews.author_association IS 'author association to the repo';
COMMENT ON COLUMN public.github_pull_request_reviews.author_can_push_to_repository IS 'boolean to determine if author can push to the repo';
COMMENT ON COLUMN public.github_pull_request_reviews.body IS 'body of the review';
COMMENT ON COLUMN public.github_pull_request_reviews.comment_count IS 'number of comments associated to the review';
COMMENT ON COLUMN public.github_pull_request_reviews.created_at IS 'timestamp of when the review was created';
COMMENT ON COLUMN public.github_pull_request_reviews.created_via_email IS 'boolean to determine if the review was created via email';
COMMENT ON COLUMN public.github_pull_request_reviews.editor_login IS 'login of the editor of the review';
COMMENT ON COLUMN public.github_pull_request_reviews.last_edited_at IS 'timestamp of when the review was last edited';
COMMENT ON COLUMN public.github_pull_request_reviews.published_at IS 'timestamp of when the review was published';
COMMENT ON COLUMN public.github_pull_request_reviews.state IS 'state of the review';
COMMENT ON COLUMN public.github_pull_request_reviews.submitted_at IS 'timestamp of when the review was submitted';
COMMENT ON COLUMN public.github_pull_request_reviews.updated_at IS 'timestamp of when the review was updated';
COMMENT ON COLUMN public.github_pull_request_reviews._mergestat_synced_at IS 'timestamp when record was synced into the MergeStat database';

COMMENT ON TABLE public.github_pull_requests IS 'pull requests of a GitHub repo';
COMMENT ON COLUMN public.github_pull_requests.repo_id IS 'foreign key for public.repos.id';
COMMENT ON COLUMN public.github_pull_requests.additions IS 'the number of additions in the pull request';
COMMENT ON COLUMN public.github_pull_requests.deletions IS 'the number of deletions in the pull request';
COMMENT ON COLUMN public.github_pull_requests.author_login IS 'login of the author of the pull request';
COMMENT ON COLUMN public.github_pull_requests.author_association IS 'author association to the repo';
COMMENT ON COLUMN public.github_pull_requests.author_avatar_url IS 'URL to the avatar of the author of the pull request';
COMMENT ON COLUMN public.github_pull_requests.author_name IS 'name of the author of the pull request';
COMMENT ON COLUMN public.github_pull_requests.base_ref_oid IS 'the base ref object id associated with the pull request';
COMMENT ON COLUMN public.github_pull_requests.base_ref_name IS 'the name of base ref associated with the pull request';
COMMENT ON COLUMN public.github_pull_requests.base_repository_name IS 'the name of the base repo for the pull request';
COMMENT ON COLUMN public.github_pull_requests.body IS 'body of the pull request';
COMMENT ON COLUMN public.github_pull_requests.changed_files IS 'the number of files changed/modified in the pull request';
COMMENT ON COLUMN public.github_pull_requests.closed IS 'boolean to determine if the pull request is closed';
COMMENT ON COLUMN public.github_pull_requests.closed_at IS 'timestamp of when the pull request was closed';
COMMENT ON COLUMN public.github_pull_requests.comment_count IS 'the number of comments in the pull request';
COMMENT ON COLUMN public.github_pull_requests.created_at IS 'timestamp of when the pull request was created';
COMMENT ON COLUMN public.github_pull_requests.created_via_email IS 'boolean to determine if the pull request was created via email';
COMMENT ON COLUMN public.github_pull_requests.database_id IS 'GitHub database_id of the pull request';
COMMENT ON COLUMN public.github_pull_requests.editor_login IS 'login of the editor of the pull request';
COMMENT ON COLUMN public.github_pull_requests.head_ref_oid IS 'the head ref object id associated with the pull request';
COMMENT ON COLUMN public.github_pull_requests.head_ref_name IS 'the name of head ref associated with the pull request';
COMMENT ON COLUMN public.github_pull_requests.head_repository_name IS 'the name of the head repo for the pull request';
COMMENT ON COLUMN public.github_pull_requests.is_draft IS 'boolean to determine if the pull request is a draft';
COMMENT ON COLUMN public.github_pull_requests.label_count IS 'number of labels associated to the pull request';
COMMENT ON COLUMN public.github_pull_requests.last_edited_at IS 'timestamp of when the pull request was last edited';
COMMENT ON COLUMN public.github_pull_requests.locked IS 'boolean to determine if the pull request is locked';
COMMENT ON COLUMN public.github_pull_requests.maintainer_can_modify IS 'boolean to determine if a maintainer can modify the pull request';
ALTER TABLE github_pull_requests
DROP COLUMN IF EXISTS mantainer_can_modify;
COMMENT ON COLUMN public.github_pull_requests.mergeable IS 'mergeable state of the pull request';
COMMENT ON COLUMN public.github_pull_requests.merged IS 'boolean to determine if the pull request is merged';
COMMENT ON COLUMN public.github_pull_requests.merged_at IS 'timestamp of when the pull request was merged';
COMMENT ON COLUMN public.github_pull_requests.merged_by IS 'actor who merged the pull request';
COMMENT ON COLUMN public.github_pull_requests.number IS 'GitHub number of the pull request';
COMMENT ON COLUMN public.github_pull_requests.participant_count IS 'number of participants associated to the pull request';
COMMENT ON COLUMN public.github_pull_requests.published_at IS 'timestamp of when the pull request was published';
COMMENT ON COLUMN public.github_pull_requests.review_decision IS 'review decision of the pull request';
COMMENT ON COLUMN public.github_pull_requests.state IS 'state of the pull request';
COMMENT ON COLUMN public.github_pull_requests.title IS 'title of the pull request';
COMMENT ON COLUMN public.github_pull_requests.updated_at IS 'timestamp of when the pull request was updated';
COMMENT ON COLUMN public.github_pull_requests.url IS 'GitHub URL of the pull request';
COMMENT ON COLUMN public.github_pull_requests.labels IS 'labels associated to the pull request';
COMMENT ON COLUMN public.github_pull_requests._mergestat_synced_at IS 'timestamp when record was synced into the MergeStat database';

COMMENT ON TABLE public.github_repo_info IS 'info/metadata of a GitHub repo';
COMMENT ON COLUMN public.github_repo_info.repo_id IS 'foreign key for public.repos.id';
COMMENT ON COLUMN public.github_repo_info.owner IS 'the user or organization that owns the repo';
COMMENT ON COLUMN public.github_repo_info.name IS 'the name of the repo';
COMMENT ON COLUMN public.github_repo_info.created_at IS 'timestamp of when the repo was created';
COMMENT ON COLUMN public.github_repo_info.default_branch_name IS 'the name of the default branch for the repo';
COMMENT ON COLUMN public.github_repo_info.description IS 'the description for the repo';
COMMENT ON COLUMN public.github_repo_info.disk_usage IS 'the number of kilobytes on disk for the repo';
COMMENT ON COLUMN public.github_repo_info.fork_count IS 'number of forks associated to the repo';
COMMENT ON COLUMN public.github_repo_info.homepage_url IS 'the GitHub homepage URL for the repo';
COMMENT ON COLUMN public.github_repo_info.is_archived IS 'boolean to determine if the repo is archived';
COMMENT ON COLUMN public.github_repo_info.is_disabled IS 'boolean to determine if the repo is disabled';
COMMENT ON COLUMN public.github_repo_info.is_mirror IS 'boolean to determine if the repo is a mirror';
COMMENT ON COLUMN public.github_repo_info.is_private IS 'boolean to determine if the repo is private';
COMMENT ON COLUMN public.github_repo_info.total_issues_count IS 'number of issues associated to the repo';
COMMENT ON COLUMN public.github_repo_info.latest_release_author IS 'the author of the latest release in the repo';
COMMENT ON COLUMN public.github_repo_info.latest_release_created_at IS 'timestamp of the creation of the latest release in the repo';
COMMENT ON COLUMN public.github_repo_info.latest_release_name IS 'the name of the latest release in the repo';
COMMENT ON COLUMN public.github_repo_info.latest_release_published_at IS 'timestamp of the publishing of the latest release in the repo';
COMMENT ON COLUMN public.github_repo_info.license_key IS 'the license key for the repo';
COMMENT ON COLUMN public.github_repo_info.license_name IS 'the license name for the repo';
COMMENT ON COLUMN public.github_repo_info.license_nickname IS 'the license nickname for the repo';
COMMENT ON COLUMN public.github_repo_info.open_graph_image_url IS 'the URL for the image used to represent this repository in Open Graph data';
COMMENT ON COLUMN public.github_repo_info.primary_language IS 'the primary language for the repo';
COMMENT ON COLUMN public.github_repo_info.pushed_at IS 'timestamp of the latest push to the repo';
COMMENT ON COLUMN public.github_repo_info.releases_count IS 'number of releases associated to the repo';
COMMENT ON COLUMN public.github_repo_info.stargazers_count IS 'number of stargazers associated to the repo';
COMMENT ON COLUMN public.github_repo_info.updated_at IS 'timestamp of the latest update to the repo';
COMMENT ON COLUMN public.github_repo_info.watchers_count IS 'number of watchers associated to the repo';
COMMENT ON COLUMN public.github_repo_info._mergestat_synced_at IS 'timestamp when record was synced into the MergeStat database';

COMMENT ON TABLE public.github_stargazers IS 'stargazers of a GitHub repo';
COMMENT ON COLUMN public.github_stargazers.repo_id IS 'foreign key for public.repos.id';
COMMENT ON COLUMN public.github_stargazers.login IS 'login of the user who starred the repo';
COMMENT ON COLUMN public.github_stargazers.email IS 'email of the user who starred the repo';
COMMENT ON COLUMN public.github_stargazers.name IS 'name of the user who starred the repo';
COMMENT ON COLUMN public.github_stargazers.bio IS 'public profile bio of the user who starred the repo';
COMMENT ON COLUMN public.github_stargazers.company IS 'company of the user who starred the repo';
COMMENT ON COLUMN public.github_stargazers.avatar_url IS 'URL to the avatar of the user who starred the repo';
COMMENT ON COLUMN public.github_stargazers.created_at IS 'timestamp of when the user was created who starred the repo';
COMMENT ON COLUMN public.github_stargazers.updated_at IS 'timestamp of the latest update to the user who starred the repo';
COMMENT ON COLUMN public.github_stargazers.twitter IS 'twitter of the user who starred the repo';
COMMENT ON COLUMN public.github_stargazers.website IS 'website of the user who starred the repo';
COMMENT ON COLUMN public.github_stargazers.location IS 'location of the user who starred the repo';
COMMENT ON COLUMN public.github_stargazers.starred_at IS 'timestamp the user starred the repo';
COMMENT ON COLUMN public.github_stargazers._mergestat_synced_at IS 'timestamp when record was synced into the MergeStat database';

COMMENT ON TABLE public.repos IS 'git repositories to track';
COMMENT ON COLUMN public.repos.id IS 'MergeStat identifier for the repo';
COMMENT ON COLUMN public.repos.repo IS 'URL for the repo';
COMMENT ON COLUMN public.repos.ref IS 'ref for the repo';
COMMENT ON COLUMN public.repos.is_github IS 'boolean to determine if the repo is in GitHub';
COMMENT ON COLUMN public.repos.created_at IS 'timestamp of when the MergeStat repo entry was created';
COMMENT ON COLUMN public.repos.settings IS 'JSON settings for the repo';
COMMENT ON COLUMN public.repos.tags IS 'array of tags for the repo for topics in GitHub as well as tags added in MergeStat';
COMMENT ON COLUMN public.repos.repo_import_id IS 'foreign key for mergestat.repo_imports.id';
ALTER TABLE public.repos
DROP COLUMN IF EXISTS _mergestat_synced_at;

COMMENT ON TABLE public.syft_repo_scans IS 'Syft repo scans';
COMMENT ON COLUMN public.syft_repo_scans.repo_id IS 'foreign key for public.repos.id';
COMMENT ON COLUMN public.syft_repo_scans.results IS 'JSON results from Syft repo scan';
ALTER TABLE public.syft_repo_scans
ADD COLUMN IF NOT EXISTS _mergestat_synced_at timestamp with time zone DEFAULT now() NOT NULL;
COMMENT ON COLUMN public.syft_repo_scans._mergestat_synced_at IS 'timestamp when record was synced into the MergeStat database';

COMMENT ON VIEW public.syft_repo_artifacts IS 'view of Syft repo scans artifacts';
COMMENT ON COLUMN public.syft_repo_artifacts.repo_id IS 'foreign key for public.repos.id';
COMMENT ON COLUMN public.syft_repo_artifacts.artifact IS 'artifact JSON results from Syft repo scan';
COMMENT ON COLUMN public.syft_repo_artifacts.id IS 'artifact id';
COMMENT ON COLUMN public.syft_repo_artifacts.name IS 'artifact name';
COMMENT ON COLUMN public.syft_repo_artifacts.version IS 'artifact version';
COMMENT ON COLUMN public.syft_repo_artifacts.type IS 'artifact type';
COMMENT ON COLUMN public.syft_repo_artifacts.found_by IS 'artifact found_by';
COMMENT ON COLUMN public.syft_repo_artifacts.locations IS 'artifact locations';
COMMENT ON COLUMN public.syft_repo_artifacts.licenses IS 'artifact licenses';
COMMENT ON COLUMN public.syft_repo_artifacts.language IS 'artifact language';
COMMENT ON COLUMN public.syft_repo_artifacts.cpes IS 'artifact cpes';
COMMENT ON COLUMN public.syft_repo_artifacts.purl IS 'artifact purl';

COMMENT ON TABLE public.trivy_repo_scans IS 'Trivy repo scans';
COMMENT ON COLUMN public.trivy_repo_scans.repo_id IS 'foreign key for public.repos.id';
COMMENT ON COLUMN public.trivy_repo_scans.results IS 'JSON results from Trivy repo scan';
COMMENT ON COLUMN public.trivy_repo_scans._mergestat_synced_at IS 'timestamp when record was synced into the MergeStat database';

COMMENT ON VIEW public.trivy_repo_vulnerabilities IS 'view of Trivy repo scans vulnerabilities';
COMMENT ON COLUMN public.trivy_repo_vulnerabilities.repo_id IS 'foreign key for public.repos.id';
COMMENT ON COLUMN public.trivy_repo_vulnerabilities.target IS 'vulnerability target';
COMMENT ON COLUMN public.trivy_repo_vulnerabilities.class IS 'vulnerability class';
COMMENT ON COLUMN public.trivy_repo_vulnerabilities.type IS 'vulnerability type';
COMMENT ON COLUMN public.trivy_repo_vulnerabilities.vulnerability IS 'vulnerability JSON results of Trivy scan';
COMMENT ON COLUMN public.trivy_repo_vulnerabilities.vulnerability_id IS 'vulnerability id';
COMMENT ON COLUMN public.trivy_repo_vulnerabilities.vulnerability_pkg_name IS 'vulnerability package name';
COMMENT ON COLUMN public.trivy_repo_vulnerabilities.vulnerability_installed_version IS 'vulnerability installed version';
COMMENT ON COLUMN public.trivy_repo_vulnerabilities.vulnerability_severity IS 'vulnerability severity';
COMMENT ON COLUMN public.trivy_repo_vulnerabilities.vulnerability_title IS 'vulnerability title';
COMMENT ON COLUMN public.trivy_repo_vulnerabilities.vulnerability_description IS 'vulnerability description';
COMMENT ON COLUMN public.trivy_repo_vulnerabilities._mergestat_synced_at IS 'timestamp when record was synced into the MergeStat database';

COMMENT ON TABLE public.schema_migrations IS 'MergeStat internal table to track schema migrations';
COMMENT ON TABLE public.schema_migrations_history IS 'MergeStat internal table to track schema migrations history';

COMMIT;
