import Result
import Swish

private struct GetEmailLoginRequest: Request {
    typealias ResponseObject = Bool
    typealias ResponseParser = StringParser
    
    fileprivate static let authSendUrl = "api/auth/send"
    
    let url: String
    let body: [String: String]
    
    init(clientId: String, redirectUri:String, email: String) {
        url = GetEmailLoginRequest.authSendUrl
        body = createRequestParameters(clientId: clientId, redirectUri: redirectUri, email: email)
    }
    
    func build() -> URLRequest {
        return createRequest(.POST, url, body: body as [String : AnyObject]?) as URLRequest
    }
    
    fileprivate func parse(_ s: String) -> Result<Bool, SwishError> {
        return Result(true)
    }
}

public extension APIClient {
    /// Get a Passport access token using a Passport auth `code`.
    ///
    /// - parameter clientId: The unique identifier of your application.
    /// - parameter redirectUri: The redirect URI for the `provider`.
    /// - parameter email: The email address associated with the account.
    static func requestEmailLogin(_ clientId: String, redirectUri:String, email: String, completionHandler: @escaping (Result<Bool, SwishError>) -> Void) {
        let request = GetEmailLoginRequest(clientId: clientId, redirectUri: redirectUri, email: email)
        let _ = staticJsonlessClient.performRequest(request, completionHandler: completionHandler)
    }
}
