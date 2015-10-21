import Mockingjay

func api(method: HTTPMethod, _ uri: String, _ token: String)(request: NSURLRequest) -> Bool {
    guard let headers = request.allHTTPHeaderFields,
        authorization = headers["Authorization"] where
        authorization == "Bearer \(token)"
    else {
        return false
    }
    
    return api(method, uri)(request: request)
}

func api(method: HTTPMethod, _ uri: String)(request: NSURLRequest) -> Bool {
    guard let headers = request.allHTTPHeaderFields,
        accept = headers["Accept"],
        acceptEncoding = headers["Accept-Encoding"],
        contentType = headers["Content-Type"] where
        accept == "application/json" &&
        contentType == "application/json" &&
        acceptEncoding == "gzip;q=1.0,compress;q=0.5"
    else {
        return false
    }
    
    return http(method, uri: uri)(request: request)
}
