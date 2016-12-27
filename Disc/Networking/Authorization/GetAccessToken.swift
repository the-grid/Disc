import Result
import Swish

private struct GetAccessTokenRequest: Request {
    typealias ResponseObject = AccessToken
    
    fileprivate static let authLoginUrl = "api/auth/login"
    fileprivate static let authRefreshUrl = "api/auth/token"
    
    let url: String
    let body: [String: String]
    var method: RequestMethod = .POST
    
    init(clientId: String, clientSecret: String, code: String) {
        url = "login/authorize/token"
        body = createRequestParameters(clientId: clientId, clientSecret: clientSecret, code: code)
    }
    
    init(clientId: String, scopes: [Scope] = [], provider: Provider, token: String, secret: String?) {
        url = GetAccessTokenRequest.authLoginUrl
        body = createRequestParameters(clientId: clientId, scopes: scopes, provider: provider, token: token, secret: secret)
    }
    
    init(clientId: String, scopes: [Scope] = [], provider: Provider, code: String, redirectUri: String) {
        url = GetAccessTokenRequest.authLoginUrl
        body = createRequestParameters(clientId: clientId, scopes: scopes, provider: provider, code: code, redirectUri: redirectUri)
    }
    
    init(clientId: String, scopes: [Scope] = [], provider: Provider, token: String, userId: String) {
        url = GetAccessTokenRequest.authLoginUrl
        body = createRequestParameters(clientId: clientId, scopes: scopes, provider: provider, token: token, userId: userId)
    }
    
    init(clientId: String, refreshToken: String) {
        method = .PUT
        url = GetAccessTokenRequest.authRefreshUrl
        body = createRequestParameters(clientId: clientId, refreshToken: refreshToken)
    }
    
    func build() -> URLRequest {
        return createRequest(method, url, body: body as [String : AnyObject]?) as URLRequest
    }
}

public extension APIClient {
    /// Get a Passport access token using a Passport auth `code`.
    ///
    /// - parameter clientId: The unique identifier of your application.
    /// - parameter clientSecret: Your application's passphrase.
    /// - parameter code: The access grant received in the `code` query
    /// parameter of the `redirectUri` that was passed to `init`.
    static func getAccessToken(_ clientId: String, clientSecret: String, code: String, completionHandler: @escaping (Result<AccessToken, SwishError>) -> Void) {
        let request = GetAccessTokenRequest(clientId: clientId, clientSecret: clientSecret, code: code)
        let _ = staticClient.performRequest(request, completionHandler: completionHandler)
    }
    
    /// Get a Passport access token using an OAuth provider access token.
    ///
    /// - parameter clientId: The unique identifier of your application.
    /// - parameter scopes: The desired authentication scopes.
    /// - parameter provider: The OAuth provider.
    /// - parameter token: The access token for the `provider`.
    /// - parameter secret: The token secret for the `provider`.
    static func getAccessToken(_ clientId: String, scopes: [Scope] = [], provider: Provider, token: String, secret: String? = nil, completionHandler: @escaping (Result<AccessToken, SwishError>) -> Void) {
        let request = GetAccessTokenRequest(clientId: clientId, scopes: scopes, provider: provider, token: token, secret: secret)
        let _ = staticClient.performRequest(request, completionHandler: completionHandler)
    }
    
    /// Get a Passport access token using an OAuth provider auth `code`.
    ///
    /// - parameter clientId: The unique identifier of your application.
    /// - parameter scopes: The desired authentication scopes.
    /// - parameter provider: The OAuth provider.
    /// - parameter code: The auth code for the `provider`.
    /// - parameter redirectUri: The redirect URI for the `provider`.
    static func getAccessToken(_ clientId: String, scopes: [Scope] = [], provider: Provider, code: String, redirectUri: String, completionHandler: @escaping (Result<AccessToken, SwishError>) -> Void) {
        let request = GetAccessTokenRequest(clientId: clientId, scopes: scopes, provider: provider, code: code, redirectUri: redirectUri)
        let _ = staticClient.performRequest(request, completionHandler: completionHandler)
    }
    
    /// Get a Passport access token using a token and user id.
    ///
    /// - parameter clientId: The unique identifier of your application.
    /// - parameter scopes: The desired authentication scopes.
    /// - parameter provider: The OAuth provider.
    /// - parameter token: The access token for the `provider`.
    /// - parameter userId: The UUID of the user.
    static func getAccessToken(_ clientId: String, scopes: [Scope] = [], provider: Provider, token: String, userId: String, completionHandler: @escaping (Result<AccessToken, SwishError>) -> Void) {
        let request = GetAccessTokenRequest(clientId: clientId, scopes: scopes, provider: provider, token: token, userId: userId)
        let _ = staticClient.performRequest(request, completionHandler: completionHandler)
    }
    
    /// Get a Passport access token with a refresh token.
    ///
    /// - parameter clientId: The unique identifier of your application.
    /// - parameter refreshToken: The passport provided refresh token.
    static func getAccessToken(_ clientId: String, refreshToken: String, completionHandler: @escaping (Result<AccessToken, SwishError>) -> Void) {
        let request = GetAccessTokenRequest(clientId: clientId, refreshToken: refreshToken)
        let _ = staticClient.performRequest(request, completionHandler: completionHandler)
    }
}
