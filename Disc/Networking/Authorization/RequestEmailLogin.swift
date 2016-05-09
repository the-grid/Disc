import Result
import Swish

private struct GetEmailLoginRequest: Request {
    typealias ResponseObject = Bool
    typealias ResponseParser = StringParser
    
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
    
    private func parse(s: String) -> Result<Bool, SwishError> {
        return Result(true)
    }
}

public extension APIClient {
    /// Get a Passport access token using a Passport auth `code`.
    ///
    /// - parameter clientId: The unique identifier of your application.
    /// - parameter redirectUri: The redirect URI for the `provider`.
    /// - parameter email: The email address associated with the account.
    static func requestEmailLogin(clientId: String, redirectUri:String, email: String, completionHandler: Result<Bool, SwishError> -> Void) {
        let request = GetEmailLoginRequest(clientId: clientId, redirectUri: redirectUri, email: email)
        staticJsonlessClient.performRequest(request, completionHandler: completionHandler)
    }
}
