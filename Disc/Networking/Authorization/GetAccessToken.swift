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

public extension OAuthClient {
    /// Get an access token using the provided `code`.
    /// - parameter code: The access grant received in the `code` query
    /// parameter of the `redirectUri` that was passed to `init`.
    func getAccessToken(code: String, completionHandler: Result<AccessToken, NSError> -> Void) {
        let request = GetAccessTokenRequest(clientId: clientId, clientSecret: clientSecret, code: code)
        client.performRequest(request, completionHandler: completionHandler)
    }
}
