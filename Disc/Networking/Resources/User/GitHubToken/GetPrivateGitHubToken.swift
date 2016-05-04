import Result
import Swish

private struct GetPrivateGitHubTokenRequest: Request {
    typealias ResponseObject = GitHubToken
    let token: String
    
    func build() -> NSURLRequest {
        return createRequest(.GET, "api/user/github_private", token: token)
    }
}

public extension APIClient {
    /// Get the current user's private GitHub token.
    /// - requires: An access token obtained with the `GitHubPrivate` scope.
    func getPrivateGitHubToken(completionHandler: Result<GitHubToken, SwishError> -> Void) {
        let request = GetPrivateGitHubTokenRequest(token: token)
        client.performRequest(request, completionHandler: completionHandler)
    }
}
