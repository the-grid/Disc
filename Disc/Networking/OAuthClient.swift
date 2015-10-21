import Swish

public struct OAuthClient {
    let client = Swish.APIClient()
    let clientId: String
    let clientSecret: String
    let redirectUri: String
    
    /// Create an OAuthClient that will convert authentication grants to access
    /// tokens with the provided `clientId`, `clientSecret`, and `redirectUri`.
    /// - parameter clientId: The unique identifier of your application.
    /// - parameter clientSecret: Your application's passphrase.
    /// - parameter redirectUri: Your callback URI.
    public init(clientId: String, clientSecret: String, redirectUri: String) {
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.redirectUri = redirectUri
    }
}
