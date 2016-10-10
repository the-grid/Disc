import Result
import Swish

private struct DeleteIdentityRequest: Request {
    typealias ResponseObject = EmptyResponse
    
    let token: String
    let id: Int

    func build() -> URLRequest {
        return createRequest(.DELETE, "api/user/identities/\(id)", token: token) as URLRequest
    }
}

public extension APIClient {
    /// Delete the identity with the provided `id`.
    ///
    /// - parameter id: The ID of the identity.
    func deleteIdentity(_ id: Int, completionHandler: @escaping (Result<EmptyResponse, SwishError>) -> Void) {
        let request = DeleteIdentityRequest(token: token, id: id)
        let _ = client.performRequest(request, completionHandler: completionHandler)
    }
}
