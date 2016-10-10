import Result
import Swish

private struct GetPrivateGitHubTokenRequest: Request {
    typealias ResponseObject = GitHubToken
    let token: String
    
    func build() -> URLRequest {
        return createRequest(.GET, "api/user/github_private", token: token) as URLRequest
    }
}

public extension APIClient {
    /// Get the current user's private GitHub token.
    /// - requires: An access token obtained with the `GitHubPrivate` scope.
    func getPrivateGitHubToken(_ completionHandler: @escaping (Result<GitHubToken, SwishError>) -> Void) {
        let request = GetPrivateGitHubTokenRequest(token: token)
        let _ = client.performRequest(request, completionHandler: completionHandler)
    }
}
