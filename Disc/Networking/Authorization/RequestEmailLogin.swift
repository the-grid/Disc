import Result
import Swish

private struct RequestEmailLogin: Request {
    typealias ResponseType = EmptyResponse
    
    private static let authSendUrl = "api/auth/send"
    
    let url: String
    let body: [String: String]
    
    init(clientId: String, email: String) {
        url = RequestEmailLogin.authSendUrl
        body = createRequestParameters(clientId: clientId, email: email)
    }
    
    func build() -> NSURLRequest {
        return createRequest(.POST, url, body: body)
    }
}