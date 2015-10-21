import Foundation
import Swish

protocol AuthenticatedRequest {
    var token: String { get }
}

func request(method: RequestMethod, _ path: String, token: String) -> NSMutableURLRequest {
    let url = NSURL(string: baseURL + path)!
    let request = NSMutableURLRequest(URL: url)
    
    request.HTTPMethod = method.rawValue
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("gzip;q=1.0,compress;q=0.5", forHTTPHeaderField: "Accept-Encoding")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    return request
}
