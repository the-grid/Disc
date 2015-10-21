import Result
import Swish

private struct GetPublicGitHubTokenRequest: Request, AuthenticatedRequest {
    typealias ResponseType = GitHubToken
    let token: String
    
    func build() -> NSURLRequest {
        return request(.GET, "api/user/github", token: token)
    }
}

public extension APIClient {
    /// Get the current user's public GitHub token.
    /// - requires: An access token obtained with the `GitHubPublic` scope.
    func getPublicGitHubToken(completionHandler: Result<GitHubToken, NSError> -> Void) {
        let request = GetPublicGitHubTokenRequest(token: token)
        client.performRequest(request, completionHandler: completionHandler)
    }
}
