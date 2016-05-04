import Result
import Swish

private struct GetIdentityRequest: Request {
    typealias ResponseType = Identity
    
    let token: String
    let id: Int
    
    func build() -> NSURLRequest {
        return createRequest(.GET, "api/user/identities/\(id)", token: token)
    }
}

public extension APIClient {
    /// Get the identity with the provided `id`.
    ///
    /// - parameter id: The ID of the identity.
    func getIdentity(id: Int, completionHandler: Result<Identity, SwishError> -> Void) {
        let request = GetIdentityRequest(token: token, id: id)
        client.performRequest(request, completionHandler: completionHandler)
    }
}
