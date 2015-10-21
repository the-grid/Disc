import Result
import Swish

private struct DeleteIdentityRequest: Request, AuthenticatedRequest {
    typealias ResponseType = EmptyResponse
    
    let token: String
    let id: Int
    
    func build() -> NSURLRequest {
        return request(.GET, "api/user/identities/remove/\(id)", token: token)
    }
}

public extension APIClient {
    /// Delete the identity with the provided `id`.
    /// - parameter identity: The ID of the identity.
    func deleteIdentity(id: Int, completionHandler: Result<EmptyResponse, NSError> -> Void) {
        let request = DeleteIdentityRequest(token: token, id: id)
        client.performRequest(request, completionHandler: completionHandler)
    }
}
