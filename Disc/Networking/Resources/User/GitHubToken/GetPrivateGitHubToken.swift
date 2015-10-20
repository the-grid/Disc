import Result
import Swish

private struct GetPrivateGitHubTokenRequest: Request, AuthenticatedRequest {
    typealias ResponseType = GitHubToken
    let token: String
    
    func build() -> NSURLRequest {
        return request(.GET, "user/github_private", token: token)
    }
}

public extension APIClient {
    func getPrivateGitHubToken(completionHandler: Result<GitHubToken, NSError> -> Void) {
        let request = GetPrivateGitHubTokenRequest(token: token)
        client.performRequest(request, completionHandler: completionHandler)
    }
}
