import Result
import Swish

private struct DeleteIdentityRequest: Request {
    typealias ResponseObject = EmptyResponse
    
    let token: String
    let id: Int
    
    func build() -> NSURLRequest {
        return createRequest(.DELETE, "api/user/identities/\(id)", token: token)
    }
}

public extension APIClient {
    /// Delete the identity with the provided `id`.
    ///
    /// - parameter id: The ID of the identity.
    func deleteIdentity(id: Int, completionHandler: Result<EmptyResponse, SwishError> -> Void) {
        let request = DeleteIdentityRequest(token: token, id: id)
        client.performRequest(request, completionHandler: completionHandler)
    }
}
