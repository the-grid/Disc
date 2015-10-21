import Result
import Swish

private struct GetUserRequest: Request, AuthenticatedRequest {
    typealias ResponseType = User
    
    let token: String
    let id: String?
    
    init(token: String, id: String? = nil) {
        self.token = token
        self.id = id
    }
    
    func build() -> NSURLRequest {
        let path: String
        
        if let id = id {
            path = "/\(id)"
        } else {
            path = ""
        }
        
        return request(.GET, "api/user" + path, token: token)
    }
}

public extension APIClient {
    /// Get the current user.
    func getUser(completionHandler: Result<User, NSError> -> Void) {
        let request = GetUserRequest(token: token)
        client.performRequest(request, completionHandler: completionHandler)
    }
    
    /// Get the user with the provided `id`.
    /// - parameter id: The ID of the user.
    func getUser(id: String, completionHandler: Result<User, NSError> -> Void) {
        let request = GetUserRequest(token: token, id: id)
        client.performRequest(request, completionHandler: completionHandler)
    }
}
