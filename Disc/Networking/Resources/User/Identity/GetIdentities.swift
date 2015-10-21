import Result
import Swish

private struct GetIdentitiesRequest: Request {
    typealias ResponseType = [Identity]
    let token: String
    
    func build() -> NSURLRequest {
        return createRequest(.GET, "api/user/identities", token: token)
    }
}

public extension APIClient {
    /// Get the identities for the current user.
    func getIdentities(completionHandler: Result<[Identity], NSError> -> Void) {
        let request = GetIdentitiesRequest(token: token)
        client.performRequest(request, completionHandler: completionHandler)
    }
}
