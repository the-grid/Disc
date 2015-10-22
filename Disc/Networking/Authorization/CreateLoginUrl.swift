public extension OAuthClient {
    /// Create a URL that can be opened in a web browser to request permission
    /// to access a user's account. If a user authorizes the application, the
    /// browser will redirect to the provided `redirectUri` that was passed to
    /// `init`. Included will be a `code` query string parameter for use with
    /// `getAccessToken(code:completionHandler:)`.
    ///
    /// - parameter scopes: The desired authentication scopes.
    /// - parameter provider: The desired identity provider, if any.
    public func createLoginUrl(scopes scopes: [Scope] = [], provider: Provider? = nil) -> NSURL? {
        let queryItems = [
            "client_id": clientId,
            "redirect_uri": redirectUri,
            "response_type": "code",
            "scope": scopes.map({ $0.rawValue }).joinWithSeparator(",")
        ]
        
        let pathComponent: String
        
        if let provider = provider {
            pathComponent = "/\(provider.rawValue)"
        } else {
            pathComponent = ""
        }

        return createUrl("login/authorize" + pathComponent, queryItems)
    }
}
