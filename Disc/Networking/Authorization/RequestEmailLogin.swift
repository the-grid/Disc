import Result
import Swish

private struct RequestEmailLogin: Request {
    typealias ResponseObject = EmptyResponse
    
    private static let authSendUrl = "api/auth/send"
    
    let url: String
    let body: [String: String]
    
    init(clientId: String, redirectUri:String, email: String) {
        url = RequestEmailLogin.authSendUrl
        body = createRequestParameters(clientId: clientId, redirectUri: redirectUri, email: email)
    }
    
    func build() -> NSURLRequest {
        return createRequest(.POST, url, body: body)
    }
}