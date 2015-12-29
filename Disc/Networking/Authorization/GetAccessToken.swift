import Result
import Swish

private struct GetAccessTokenRequest: Request {
    typealias ResponseType = AccessToken
    
    let clientId: String
    let clientSecret: String
    let code: String
    
    func build() -> NSURLRequest {
        let body = [
            "client_id": clientId,
            "client_secret": clientSecret,
            "code": code,
            "grant_type": "authorization_code",
        ]
        
        return createRequest(.POST, "login/authorize/token", body: body)
    }
}

public extension APIClient {
    /// Get an access token using the provided `code`.
    ///
    /// - parameter clientId: The unique identifier of your application.
    /// - parameter clientSecret: Your application's passphrase.
    /// - parameter code: The access grant received in the `code` query
    /// parameter of the `redirectUri` that was passed to `init`.
    static func getAccessToken(clientId clientId: String, clientSecret: String, code: String, completionHandler: Result<AccessToken, NSError> -> Void) {
        let request = GetAccessTokenRequest(clientId: clientId, clientSecret: clientSecret, code: code)
        auth.performRequest(request, completionHandler: completionHandler)
    }
}
