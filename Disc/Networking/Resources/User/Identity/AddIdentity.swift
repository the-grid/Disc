import Result
import Swish

private struct AddIdentityRequest: Request {
    typealias ResponseType = Identity
    
    let token: String
    let provider: Provider
    let providerAccessToken: String?
    let providerTokenSecret: String?
    let authCode: String?
    let redirectUri: String?
    
    init(token: String, provider: Provider, providerAccessToken: String, providerTokenSecret: String?) {
        self.token = token
        self.provider = provider
        self.providerAccessToken = providerAccessToken
        self.providerTokenSecret = providerTokenSecret
        self.authCode = .None
        self.redirectUri = .None
    }
    
    init(token: String, provider: Provider, authCode: String, redirectUri: String) {
        self.token = token
        self.provider = provider
        self.providerAccessToken = .None
        self.providerTokenSecret = .None
        self.authCode = authCode
        self.redirectUri = redirectUri
    }
    
    func build() -> NSURLRequest {
        let defaultParameters = [
            "provider": provider.rawValue
        ]
        
        let tokenParameter: [String: AnyObject]
        let secretParameter: [String: AnyObject]
        let authCodeParameter: [String: AnyObject]
        let redirectUriParameter: [String: AnyObject]
        
        if let accessToken = providerAccessToken {
            tokenParameter = [ "token": accessToken ]
        } else {
            tokenParameter = [:]
        }
        
        if let secret = providerTokenSecret {
            secretParameter = [ "token_secret": secret ]
        } else {
            secretParameter = [:]
        }
        
        if let code = authCode {
            authCodeParameter = [ "code": code ]
        } else {
            authCodeParameter = [:]
        }
        
        if let redirect = redirectUri {
            redirectUriParameter = [ "redirect_uri": redirect ]
        } else {
            redirectUriParameter = [:]
        }
        
        let body = defaultParameters
            + tokenParameter
            + secretParameter
            + authCodeParameter
            + redirectUriParameter
        
        return createRequest(.POST, "api/user/identities", token: token, body: body)
    }
}

public extension APIClient {
    /// Add an `identity` using an access token.
    ///
    /// - parameter provider: The provider of the identity to add.
    /// - parameter token: The access token for the `provider`.
    /// - parameter secret: The token secret for the `provider`.
    func addIdentity(provider: Provider, token providerAccessToken: String, secret providerTokenSecret: String? = nil, completionHandler: Result<Identity, NSError> -> Void) {
        let request = AddIdentityRequest(
            token: token,
            provider: provider,
            providerAccessToken: providerAccessToken,
            providerTokenSecret: providerTokenSecret
        )
        
        client.performRequest(request, completionHandler: completionHandler)
    }
    
    /// Add an `identity` using an auth code.
    ///
    /// - parameter provider: The provider of the identity to add.
    /// - parameter code: The auth code for the `provider`.
    /// - parameter redirectUri: The redirect URI for the `provider`.
    func addIdentity(provider: Provider, code authCode: String, redirectUri: String, completionHandler: Result<Identity, NSError> -> Void) {
        let request = AddIdentityRequest(
            token: token,
            provider: provider,
            authCode: authCode,
            redirectUri: redirectUri
        )
        
        client.performRequest(request, completionHandler: completionHandler)
    }
}
