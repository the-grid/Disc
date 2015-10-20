import Result
import Swish

private struct GetIdentitiesRequest: Request, AuthenticatedRequest {
    typealias ResponseType = [Identity]
    let token: String
    
    func build() -> NSURLRequest {
        return request(.GET, "user/identities", token: token)
    }
}

public extension APIClient {
    func getIdentities(completionHandler: Result<[Identity], NSError> -> Void) {
        let request = GetIdentitiesRequest(token: token)
        client.performRequest(request, completionHandler: completionHandler)
    }
}
