import Mockingjay

func api(method: HTTPMethod, _ uri: String, token: String)(request: NSURLRequest) -> Bool {
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

func api(method: HTTPMethod, _ uri: String, body: [String: AnyObject])(request: NSURLRequest) -> Bool {
    guard let stream = request.HTTPBodyStream else { return false }
    
    stream.open()
    
    guard let streamJsonObject = try? NSJSONSerialization.JSONObjectWithStream(stream, options: NSJSONReadingOptions()) else {
        return false
    }
    
    guard let streamDictionary = streamJsonObject as? [String: AnyObject] else { return false }
    
    let sortedStreamDictionary = sortDictionary(streamDictionary)
    let sortedBody = sortDictionary(body)
    
    let bodyStreamJsonData = try? NSJSONSerialization.dataWithJSONObject(sortedStreamDictionary, options: NSJSONWritingOptions())
    let bodyJsonData = try? NSJSONSerialization.dataWithJSONObject(sortedBody, options: NSJSONWritingOptions())
    
    guard bodyStreamJsonData == bodyJsonData else { return false }
    
    return api(method, uri)(request: request)
}

func api(method: HTTPMethod, _ uri: String, token: String, body: [String: AnyObject])(request: NSURLRequest) -> Bool {
    return api(method, uri, token: token)(request: request) && api(method, uri, body: body)(request: request)
}

private func sortDictionary(dictionary: [String: AnyObject]) -> [String: AnyObject] {
    return dictionary
        .sort { $0.0 < $1.0 }
        .reduce([:]) { (var accumulator, pair) in
            let (key, value) = pair
            accumulator[key] = value
            return accumulator
        }
}
