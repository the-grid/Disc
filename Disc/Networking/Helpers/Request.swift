import Foundation
import Swish

private let baseUrl = URL(string: "https://passport.thegrid.io/")!


// MARK: - URL

func createUrl(_ path: String, _ queryItems: [String: String] = [:]) -> URL? {
    guard let url = URL(string: path, relativeTo: baseUrl),
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
    else {
        return .none
    }
    
    let queryItems = queryItems
        .map { URLQueryItem(name: $0, value: $1) }
        .sorted { $0.name < $1.name }
    
    components.queryItems = queryItems.isEmpty ? nil : queryItems
    return components.url
}


// MARK: - Request

func createRequest(_ method: RequestMethod, _ path: String, token: String) -> URLRequest {
    let request = createRequest(method, path)
    setAuthorizationHeaderForRequest(request, token: token)
    return request
}

func createRequest(_ method: RequestMethod, _ path: String, body: [String: AnyObject]? = nil) -> URLRequest {
    let url = createUrl(path)!
    var request = URLRequest(url: url)
    
    if let body = body {
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions())
    }
    
    request.httpMethod = method.rawValue
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("gzip;q=1.0,compress;q=0.5", forHTTPHeaderField: "Accept-Encoding")
    
    return request
}

func createRequest(_ method: RequestMethod, _ path: String, token: String, body: [String: AnyObject]) -> URLRequest {
    let request = createRequest(method, path, body: body)
    setAuthorizationHeaderForRequest(request, token: token)
    return request
}

private func setAuthorizationHeaderForRequest(_ request: URLRequest, token: String) {
    var req = request
    req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
}


// MARK: - Request Parameters

private func createRequestParameters(clientId: String) -> [String: String] {
    return [ "client_id": clientId ]
}

private func createRequestParameters(code: String) -> [String: String] {
    return [ "code": code ]
}

private func createRequestParameters(provider: Provider) -> [String: String] {
    return [ "provider": provider.rawValue ]
}

private func createRequestParameters(redirectUri: String) -> [String: String] {
    return [ "redirect_uri": redirectUri ]
}

private func createRequestParameters(secret: String?) -> [String: String] {
    guard let secret = secret else { return [:] }
    return [ "token_secret": secret ]
}

private func createRequestParameters(scopes: [Scope]) -> [String: String] {
    guard !scopes.isEmpty else { return [:] }
    return [ "scope": scopes.map({ $0.rawValue }).joined(separator: ",") ]
}

private func createRequestParameters(token: String) -> [String: String] {
    return [ "token": token ]
}

private func createRequestParameters(userId: String) -> [String: String] {
    return [ "user": userId ]
}

private func createRequestParameters(email: String) -> [String: String] {
    return [ "email": email ]
}

private func createRequestParameters(refreshToken: String) -> [String: String] {
    return [ "refresh_token": refreshToken ]
}

func createRequestParameters(clientId: String, redirectUri: String, scopes: [Scope]) -> [String: String] {
    return createRequestParameters(clientId: clientId)
        + createRequestParameters(redirectUri: redirectUri)
        + createRequestParameters(scopes: scopes)
        + [ "response_type": "code" ]
}

func createRequestParameters(clientId: String, clientSecret: String, code: String) -> [String: String] {
    return createRequestParameters(clientId: clientId)
        + createRequestParameters(code: code)
        + [ "client_secret": clientSecret, "grant_type": "authorization_code" ]
}

func createRequestParameters(scopes: [Scope] = [], provider: Provider, token: String, secret: String? = .none) -> [String: String] {
    return createRequestParameters(scopes: scopes)
        + createRequestParameters(provider: provider)
        + createRequestParameters(token: token)
        + createRequestParameters(secret: secret)
}

func createRequestParameters(scopes: [Scope] = [], provider: Provider, code: String, redirectUri: String) -> [String: String] {
    return createRequestParameters(scopes: scopes)
        + createRequestParameters(provider: provider)
        + createRequestParameters(code: code)
        + createRequestParameters(redirectUri: redirectUri)
}

func createRequestParameters(clientId: String, scopes: [Scope] = [], provider: Provider, token: String, secret: String? = .none) -> [String: String] {
    return createRequestParameters(clientId: clientId)
        + createRequestParameters(scopes: scopes, provider: provider, token: token, secret: secret)
}

func createRequestParameters(clientId: String, scopes: [Scope] = [], provider: Provider, code: String, redirectUri: String) -> [String: String] {
    return createRequestParameters(clientId: clientId)
        + createRequestParameters(scopes: scopes, provider: provider, code: code, redirectUri: redirectUri)
}

func createRequestParameters(clientId: String, scopes: [Scope] = [], provider: Provider, token: String, userId: String) -> [String: String] {
    return createRequestParameters(clientId: clientId)
        + createRequestParameters(scopes: scopes)
        + createRequestParameters(provider: provider)
        + createRequestParameters(token: token)
        + createRequestParameters(userId: userId)
}

func createRequestParameters(clientId: String, redirectUri: String, email: String) -> [String: String] {
    return createRequestParameters(clientId: clientId)
        + createRequestParameters(redirectUri: redirectUri)
        + createRequestParameters(email: email)
}

func createRequestParameters(clientId: String, refreshToken: String) -> [String: String] {
    return createRequestParameters(clientId: clientId)
        + createRequestParameters(refreshToken: refreshToken)
}

