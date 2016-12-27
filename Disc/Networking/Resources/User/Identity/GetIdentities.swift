import Result
import Swish

private struct GetIdentitiesRequest: Request {
    typealias ResponseObject = [Identity]
    let token: String
    
    func build() -> URLRequest {
        return createRequest(.GET, "api/user/identities", token: token) as URLRequest
    }
}

public extension APIClient {
    /// Get the identities for the current user.
    func getIdentities(_ completionHandler: @escaping (Result<[Identity], SwishError>) -> Void) {
        let request = GetIdentitiesRequest(token: token)
        let _ = client.performRequest(request, completionHandler: completionHandler)
    }
}
