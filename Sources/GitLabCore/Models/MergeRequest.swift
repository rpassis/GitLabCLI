import Foundation

public struct MergeRequest: Codable {
    public let project_id: Int
    public let source_branch: String
    public let target_branch: String
    public let title: String
    public let squash: Bool
    public let remove_source_branch: Bool?
    public let web_url: String?

    public init(
        project_id: Int,
        source_branch: String,
        target_branch: String,
        title: String,
        squash: Bool,
        remove_source_branch: Bool?,
        web_url: String?) {
        self.project_id = project_id
        self.source_branch = source_branch
        self.target_branch = target_branch
        self.title = title
        self.squash = squash
        self.remove_source_branch = remove_source_branch
        self.web_url = web_url
    }
}

public extension MergeRequest {
    public enum State: String {
        case opened
        case closed
        case locked
        case merged
    }

}

// Sample response
// {"id":22458465,"iid":91,"project_id":9086951,"title":"SP-723 Updated onboarding cell leading and trailing margins",
// "description":null,"state":"opened","created_at":"2019-01-15T16:56:28.182Z","updated_at":"2019-01-15T16:56:28.182Z",
// "merged_by":null,"merged_at":null,"closed_by":null,"closed_at":null,"target_branch":"develop","source_branch":
// "feature/SP-723_FeedDepthAndSpace","upvotes":0,"downvotes":0,"author":{"id":3050184,"name":"Rogerio de Paula Assis",
// "username":"rpassis","state":"active","avatar_url":"https://assets.gitlab-static.net/uploads/-/system/user/avatar/3050184/avatar.png",
// "web_url":"https://gitlab.com/rpassis"},"assignee":null,"source_project_id":9086951,"target_project_id":9086951,
// "labels":[],"work_in_progress":false,"milestone":null,"merge_when_pipeline_succeeds":false,"merge_status":"cannot_be_merged",
// "sha":"0ab85006a6fe0b8feab8ad3c49304b16bfb207b8","merge_commit_sha":null,"user_notes_count":0,"discussion_locked":null,
// "should_remove_source_branch":null,"force_remove_source_branch":null,
// "web_url":"https://gitlab.com/tinybeanskids/tinybeansapp-ios/merge_requests/91","time_stats":{"time_estimate":0,
// "total_time_spent":0,"human_time_estimate":null,"human_total_time_spent":null},"squash":false,
// "subscribed":true,"changes_count":"6","latest_build_started_at":null,"latest_build_finished_at":null,
// "first_deployed_to_production_at":null,"pipeline":null,"diff_refs":{"base_sha":"e0ff9e8c8db6d073365310ddbdc2a40baba6b1cb",
// "head_sha":"0ab85006a6fe0b8feab8ad3c49304b16bfb207b8","start_sha":"2be61aa5b31dc4ba39c78c3a2922947af95730f0"},
// "merge_error":null,"approvals_before_merge":null}%
