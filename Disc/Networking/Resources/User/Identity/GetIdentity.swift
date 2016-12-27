import Result
import Swish

private struct GetIdentityRequest: Request {
    typealias ResponseObject = Identity
    
    let token: String
    let id: Int
    
    func build() -> URLRequest {
        return createRequest(.GET, "api/user/identities/\(id)", token: token) as URLRequest
    }
}

public extension APIClient {
    /// Get the identity with the provided `id`.
    ///
    /// - parameter id: The ID of the identity.
    func getIdentity(_ id: Int, completionHandler: @escaping (Result<Identity, SwishError>) -> Void) {
        let request = GetIdentityRequest(token: token, id: id)
        let _ = client.performRequest(request, completionHandler: completionHandler)
    }
}
