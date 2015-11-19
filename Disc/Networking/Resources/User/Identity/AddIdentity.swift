import Result
import Swish

private struct AddIdentityRequest: Request {
    typealias ResponseType = Identity
    
    let token: String
    let provider: Provider
    let providerAccessToken: String
    let providerTokenSecret: String?
    
    func build() -> NSURLRequest {
        let defaultParameters = [
            "provider": provider.rawValue,
            "token": providerAccessToken
        ]
        
        let secretParameter: [String: AnyObject]
        
        if let secret = providerTokenSecret {
            secretParameter = [
                "token_secret": secret
            ]
        } else {
            secretParameter = [:]
        }
        
        let body = defaultParameters + secretParameter
        
        return createRequest(.POST, "api/user/identities", token: token, body: body)
    }
}

public extension APIClient {
    /// Add the provided `identity`.
    ///
    /// - parameter provider: The provider of the identity to add.
    /// - parameter token: The access token for the `provider`.
    /// - parameter secret: The token secret for the `provider`.
    func addIdentity(provider: Provider, token providerAccessToken: String, secret providerTokenSecret: String? = nil, completionHandler: Result<Identity, NSError> -> Void) {
        let request = AddIdentityRequest(token: token, provider: provider, providerAccessToken: providerAccessToken, providerTokenSecret: providerTokenSecret)
        client.performRequest(request, completionHandler: completionHandler)
    }
}
