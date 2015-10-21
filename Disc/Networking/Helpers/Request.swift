import Foundation
import Swish

private let baseUrl = NSURL(string: "https://passport.thegrid.io/")!

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

func createRequest(method: RequestMethod, _ path: String, token: String) -> NSMutableURLRequest {
    let request = createRequest(method, path)
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    return request
}

func createRequest(method: RequestMethod, _ path: String, _ queryItems: [String: String] = [:]) -> NSMutableURLRequest {
    let url = createUrl(path, queryItems)!
    let request = NSMutableURLRequest(URL: url)
    
    request.HTTPMethod = method.rawValue
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("gzip;q=1.0,compress;q=0.5", forHTTPHeaderField: "Accept-Encoding")
    
    return request
}