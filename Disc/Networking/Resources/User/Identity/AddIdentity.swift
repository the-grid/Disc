import Result
import Swish

private struct AddIdentityRequest: Request {
    typealias ResponseType = Identity
    
    let token: String
    let body: [String: String]
    
    init(token: String, provider: Provider, providerAccessToken: String, providerTokenSecret: String?) {
        self.token = token
        body = createRequestParameters(provider: provider, token: providerAccessToken, secret: providerTokenSecret)
    }
    
    init(token: String, provider: Provider, authCode: String, redirectUri: String) {
        self.token = token
        body = createRequestParameters(provider: provider, code: authCode, redirectUri: redirectUri)
    }
    
    func build() -> NSURLRequest {
        return createRequest(.POST, "api/user/identities", token: token, body: body)
    }
}

public extension APIClient {
    /// Add an identity using an access token.
    ///
    /// - parameter provider: The provider of the identity to add.
    /// - parameter token: The access token for the `provider`.
    /// - parameter secret: The token secret for the `provider`.
    func addIdentity(provider: Provider, token providerAccessToken: String, secret providerTokenSecret: String? = nil, completionHandler: Result<Identity, SwishError> -> Void) {
        let request = AddIdentityRequest(
            token: token,
            provider: provider,
            providerAccessToken: providerAccessToken,
            providerTokenSecret: providerTokenSecret
        )
        
        client.performRequest(request, completionHandler: completionHandler)
    }
    
    /// Add an identity using an auth code.
    ///
    /// - parameter provider: The provider of the identity to add.
    /// - parameter code: The auth code for the `provider`.
    /// - parameter redirectUri: The redirect URI for the `provider`.
    func addIdentity(provider: Provider, code authCode: String, redirectUri: String, completionHandler: Result<Identity, SwishError> -> Void) {
        let request = AddIdentityRequest(
            token: token,
            provider: provider,
            authCode: authCode,
            redirectUri: redirectUri
        )
        
        client.performRequest(request, completionHandler: completionHandler)
    }
}
