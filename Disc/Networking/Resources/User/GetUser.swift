import Result
import Swish

private struct GetUserRequest: Request, AuthenticatedRequest {
    typealias ResponseType = User
    
    let token: String
    let id: NSUUID?
    
    init(token: String, id: NSUUID? = nil) {
        self.token = token
        self.id = id
    }
    
    func build() -> NSURLRequest {
        let path: String
        
        if let id = id {
            path = "/\(id.UUIDString.lowercaseString)"
        } else {
            path = ""
        }
        
        return request(.GET, "user" + path, token: token)
    }
}

public extension APIClient {
    /// Get the current user.
    func getUser(completionHandler: Result<User, NSError> -> Void) {
        let request = GetUserRequest(token: token)
        client.performRequest(request, completionHandler: completionHandler)
    }
    
    /// Get the user with the provided `id`.
    /// - parameter id: A user's ID.
    func getUser(id: NSUUID, completionHandler: Result<User, NSError> -> Void) {
        let request = GetUserRequest(token: token, id: id)
        client.performRequest(request, completionHandler: completionHandler)
    }
}
