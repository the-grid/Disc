import Result
import Swish

private struct AddIdentityRequest: Request {
    typealias ResponseType = Identity
    
    let token: String
    let provider: Provider
    let providerAccessToken: String
    
    func build() -> NSURLRequest {
        let body = [
            "provider": provider.rawValue,
            "token": providerAccessToken
        ]
        
        return createRequest(.POST, "api/user/identities", token: token, body: body)
    }
}

public extension APIClient {
    /// Add the provided `identity`.
    ///
    /// - parameter provider: The provider of the identity to add.
    /// - parameter token: The access token for the `provider`.
    func addIdentity(provider: Provider, token providerAccessToken: String, completionHandler: Result<Identity, NSError> -> Void) {
        let request = AddIdentityRequest(token: token, provider: provider, providerAccessToken: providerAccessToken)
        client.performRequest(request, completionHandler: completionHandler)
    }
}
