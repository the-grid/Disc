import Result
import Swish

private struct GetPublicGitHubTokenRequest: Request, AuthenticatedRequest {
    typealias ResponseType = GitHubToken
    let token: String
    
    func build() -> NSURLRequest {
        return request(.GET, "user/github", token: token)
    }
}

public extension APIClient {
    func getPublicGitHubToken(completionHandler: Result<GitHubToken, NSError> -> Void) {
        let request = GetPublicGitHubTokenRequest(token: token)
        client.performRequest(request, completionHandler: completionHandler)
    }
}
