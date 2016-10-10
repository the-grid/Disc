import Result
import Swish

private struct GetPublicGitHubTokenRequest: Request {
    typealias ResponseObject = GitHubToken
    let token: String
    
    func build() -> URLRequest {
        return createRequest(.GET, "api/user/github", token: token) as URLRequest
    }
}

public extension APIClient {
    /// Get the current user's public GitHub token.
    /// - requires: An access token obtained with the `GitHubPublic` scope.
    func getPublicGitHubToken(_ completionHandler: @escaping (Result<GitHubToken, SwishError>) -> Void) {
        let request = GetPublicGitHubTokenRequest(token: token)
        let _ = client.performRequest(request, completionHandler: completionHandler)
    }
}
