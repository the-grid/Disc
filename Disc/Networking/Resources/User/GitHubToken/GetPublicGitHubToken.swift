import Result
import Swish

private struct GetPublicGitHubTokenRequest: Request {
    typealias ResponseObject = GitHubToken
    let token: String
    
    func build() -> NSURLRequest {
        return createRequest(.GET, "api/user/github", token: token)
    }
}

public extension APIClient {
    /// Get the current user's public GitHub token.
    /// - requires: An access token obtained with the `GitHubPublic` scope.
    func getPublicGitHubToken(completionHandler: Result<GitHubToken, SwishError> -> Void) {
        let request = GetPublicGitHubTokenRequest(token: token)
        client.performRequest(request, completionHandler: completionHandler)
    }
}
