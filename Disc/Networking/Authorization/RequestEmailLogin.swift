import Result
import Swish

private struct GetEmailLoginRequest: Request {
    typealias ResponseObject = EmptyResponse
    
    private static let authSendUrl = "api/auth/send"
    
    let url: String
    let body: [String: String]
    
    init(clientId: String, redirectUri:String, email: String) {
        url = GetEmailLoginRequest.authSendUrl
        body = createRequestParameters(clientId: clientId, redirectUri: redirectUri, email: email)
    }
    
    func build() -> NSURLRequest {
        return createRequest(.POST, url, body: body)
    }
}

public extension APIClient {
    /// Get a Passport access token using a Passport auth `code`.
    ///
    /// - parameter clientId: The unique identifier of your application.
    /// - parameter redirectUri: The redirect URI for the `provider`.
    /// - parameter email: The email address associated with the account.
    static func requestEmailLogin(clientId: String, redirectUri:String, email: String, completionHandler: Result<EmptyResponse, SwishError> -> Void) {
        let request = GetEmailLoginRequest(clientId: clientId, redirectUri: redirectUri, email: email)
        staticClient.performRequest(request, completionHandler: completionHandler)
    }
}