import Result
import Swish

private struct DeleteIdentityRequest: Request, AuthenticatedRequest {
    typealias ResponseType = EmptyResponse
    
    let token: String
    let identity: Identity
    
    func build() -> NSURLRequest {
        return request(.GET, "user/identities/remove/\(identity.id)", token: token)
    }
}

public extension APIClient {
    /// Delete the provided `identity`.
    /// - parameter identity: The identity to be deleted.
    func deleteIdentity(identity: Identity, completionHandler: Result<EmptyResponse, NSError> -> Void) {
        let request = DeleteIdentityRequest(token: token, identity: identity)
        client.performRequest(request, completionHandler: completionHandler)
    }
}
