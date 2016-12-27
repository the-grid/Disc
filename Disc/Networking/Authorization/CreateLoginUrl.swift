public extension APIClient {
    /// Create a URL that can be opened in a web browser to request permission
    /// to access a user's account. If a user authorizes the application, the
    /// browser will redirect to the provided `redirectUri` that was passed to
    /// `init`. Included will be a `code` query string parameter for use with
    /// `getAccessToken(code:completionHandler:)`.
    ///
    /// - parameter clientId: The unique identifier of your application.
    /// - parameter clientSecret: Your application's passphrase.
    /// - parameter redirectUri: Your callback URI.
    /// - parameter scopes: The desired authentication scopes.
    /// - parameter provider: The desired identity provider, if any.
    static func createLoginUrl(_ clientId: String, redirectUri: String, scopes: [Scope] = [], provider: Provider? = nil) -> URL? {
        let queryItems = createRequestParameters(clientId: clientId, redirectUri: redirectUri, scopes: scopes)
        
        let pathComponent: String
        
        if let provider = provider {
            pathComponent = "/\(provider.rawValue)"
        } else {
            pathComponent = ""
        }

        return createUrl("login/authorize" + pathComponent, queryItems)
    }
}
