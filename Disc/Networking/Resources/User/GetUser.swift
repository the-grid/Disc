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
    
    func build() -> URLRequest {
        let pathComponent: String
        
        if let id = id {
            pathComponent = "/\(id)"
        } else {
            pathComponent = ""
        }
        
        return createRequest(.GET, "api/user" + pathComponent, token: token) as URLRequest
    }
}

public extension APIClient {
    /// Get the current user.
    func getUser(_ completionHandler: @escaping (Result<User, SwishError>) -> Void) {
        let request = GetUserRequest(token: token)
        let _ = client.performRequest(request, completionHandler: completionHandler)
    }
    
    /// Get the user with the provided `id`.
    ///
    /// - parameter id: The ID of the user.
    func getUser(_ id: String, completionHandler: @escaping (Result<User, SwishError>) -> Void) {
        let request = GetUserRequest(token: token, id: id)
        let _ = client.performRequest(request, completionHandler: completionHandler)
    }
}
