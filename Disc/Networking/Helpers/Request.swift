import Foundation
import Swish

private let baseUrl = NSURL(string: "https://passport.thegrid.io/")!


// MARK: - URL

func createUrl(path: String, _ queryItems: [String: String] = [:]) -> NSURL? {
    guard let url = NSURL(string: path, relativeToURL: baseUrl),
        components = NSURLComponents(URL: url, resolvingAgainstBaseURL: true)
    else {
        return .None
    }
    
    let queryItems = queryItems
        .map { NSURLQueryItem(name: $0, value: $1) }
        .sort { $0.name < $1.name }
    
    components.queryItems = queryItems.isEmpty ? nil : queryItems
    return components.URL
}


// MARK: - Request

func createRequest(method: RequestMethod, _ path: String, token: String) -> NSMutableURLRequest {
    let request = createRequest(method, path)
    setAuthorizationHeaderForRequest(request, token: token)
    return request
}

func createRequest(method: RequestMethod, _ path: String, body: [String: AnyObject]? = nil) -> NSMutableURLRequest {
    let url = createUrl(path)!
    let request = NSMutableURLRequest(URL: url)
    
    if let body = body {
        request.HTTPBody = try? NSJSONSerialization.dataWithJSONObject(body, options: NSJSONWritingOptions())
    }
    
    request.HTTPMethod = method.rawValue
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("gzip;q=1.0,compress;q=0.5", forHTTPHeaderField: "Accept-Encoding")
    
    return request
}

func createRequest(method: RequestMethod, _ path: String, token: String, body: [String: AnyObject]) -> NSMutableURLRequest {
    let request = createRequest(method, path, body: body)
    setAuthorizationHeaderForRequest(request, token: token)
    return request
}

private func setAuthorizationHeaderForRequest(request: NSMutableURLRequest, token: String) {
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
}


// MARK: - Request Parameters

private func createRequestParameters(clientId clientId: String) -> [String: String] {
    return [ "client_id": clientId ]
}

private func createRequestParameters(code code: String) -> [String: String] {
    return [ "code": code ]
}

private func createRequestParameters(provider provider: Provider) -> [String: String] {
    return [ "provider": provider.rawValue ]
}

private func createRequestParameters(redirectUri redirectUri: String) -> [String: String] {
    return [ "redirect_uri": redirectUri ]
}

private func createRequestParameters(secret secret: String?) -> [String: String] {
    guard let secret = secret else { return [:] }
    return [ "token_secret": secret ]
}

private func createRequestParameters(scopes scopes: [Scope]) -> [String: String] {
    guard !scopes.isEmpty else { return [:] }
    return [ "scope": scopes.map({ $0.rawValue }).joinWithSeparator(",") ]
}

private func createRequestParameters(token token: String) -> [String: String] {
    return [ "token": token ]
}

private func createRequestParameters(userId userId: String) -> [String: String] {
    return [ "user": userId ]
}

private func createRequestParameters(email email: String) -> [String: String] {
    return [ "email": email ]
}

func createRequestParameters(clientId clientId: String, redirectUri: String, scopes: [Scope]) -> [String: String] {
    return createRequestParameters(clientId: clientId)
        + createRequestParameters(redirectUri: redirectUri)
        + createRequestParameters(scopes: scopes)
        + [ "response_type": "code" ]
}

func createRequestParameters(clientId clientId: String, clientSecret: String, code: String) -> [String: String] {
    return createRequestParameters(clientId: clientId)
        + createRequestParameters(code: code)
        + [ "client_secret": clientSecret, "grant_type": "authorization_code" ]
}

func createRequestParameters(scopes scopes: [Scope] = [], provider: Provider, token: String, secret: String? = .None) -> [String: String] {
    return createRequestParameters(scopes: scopes)
        + createRequestParameters(provider: provider)
        + createRequestParameters(token: token)
        + createRequestParameters(secret: secret)
}

func createRequestParameters(scopes scopes: [Scope] = [], provider: Provider, code: String, redirectUri: String) -> [String: String] {
    return createRequestParameters(scopes: scopes)
        + createRequestParameters(provider: provider)
        + createRequestParameters(code: code)
        + createRequestParameters(redirectUri: redirectUri)
}

func createRequestParameters(clientId clientId: String, scopes: [Scope] = [], provider: Provider, token: String, secret: String? = .None) -> [String: String] {
    return createRequestParameters(clientId: clientId)
        + createRequestParameters(scopes: scopes, provider: provider, token: token, secret: secret)
}

func createRequestParameters(clientId clientId: String, scopes: [Scope] = [], provider: Provider, code: String, redirectUri: String) -> [String: String] {
    return createRequestParameters(clientId: clientId)
        + createRequestParameters(scopes: scopes, provider: provider, code: code, redirectUri: redirectUri)
}

func createRequestParameters(clientId clientId: String, scopes: [Scope] = [], provider: Provider, token: String, userId: String) -> [String: String] {
    return createRequestParameters(clientId: clientId)
        + createRequestParameters(scopes: scopes)
        + createRequestParameters(provider: provider)
        + createRequestParameters(token: token)
        + createRequestParameters(userId: userId)
}

func createRequestParameters(clientId clientId: String, redirectUri: String, email: String) -> [String: String] {
    return createRequestParameters(clientId: clientId)
        + createRequestParameters(redirectUri: redirectUri)
        + createRequestParameters(email: email)
}

