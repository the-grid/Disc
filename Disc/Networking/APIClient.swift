import Swish

public struct APIClient {
    let client = Swish.APIClient()
    let token: String
    
    /// Create an APIClient that will authenticate requests with the provided
    /// access `token`.
    /// - parameter token: A user's access token.
    public init(token: String) {
        self.token = token
    }
}
