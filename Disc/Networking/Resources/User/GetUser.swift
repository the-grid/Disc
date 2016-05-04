import Result
import Swish

private struct GetUserRequest: Request {
    typealias ResponseObject = User
    
    let token: String
    let id: String?
    
    init(token: String, id: String? = nil) {
        self.token = token
        self.id = id
    }
    
    func build() -> NSURLRequest {
        let pathComponent: String
        
        if let id = id {
            pathComponent = "/\(id)"
        } else {
            pathComponent = ""
        }
        
        return createRequest(.GET, "api/user" + pathComponent, token: token)
    }
}

public extension APIClient {
    /// Get the current user.
    func getUser(completionHandler: Result<User, SwishError> -> Void) {
        let request = GetUserRequest(token: token)
        client.performRequest(request, completionHandler: completionHandler)
    }
    
    /// Get the user with the provided `id`.
    ///
    /// - parameter id: The ID of the user.
    func getUser(id: String, completionHandler: Result<User, SwishError> -> Void) {
        let request = GetUserRequest(token: token, id: id)
        client.performRequest(request, completionHandler: completionHandler)
    }
}
