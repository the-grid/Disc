private let discDomain = "io.thegrid.Disc"
public let NetworkErrorDataKey = discDomain + ".errorData"

extension NSError {
    static func error(_ message: String, function: String = #function, file: String = #file, line: Int = #line) -> NSError {
        var info = userInfoFor(function, file, line)
        
        info[NSLocalizedDescriptionKey] = message as AnyObject?
        
        return NSError(domain: discDomain, code: 0, userInfo: info)
    }
    
    static func error(_ statusCode: Int, data: AnyObject?, function: String = #function, file: String = #file, line: Int = #line) -> NSError {
        var info = userInfoFor(function, file, line)
        
        info[NSLocalizedDescriptionKey] = messageForStatusCode(statusCode) as AnyObject?
        info[NetworkErrorDataKey] = data
        
        return NSError(domain: discDomain, code: statusCode, userInfo: info)
    }
}

private func userInfoFor(_ function: String, _ file: String, _ line: Int) -> [String: AnyObject] {
    return [
        "\(discDomain).function": function as AnyObject,
        "\(discDomain).file": file as AnyObject,
        "\(discDomain).line": line as AnyObject,
    ]
}

private func messageForStatusCode(_ code: Int) -> String {
    switch code {
    case 300...399:
        return "Multiple choices: \(code)"
    case 400...499:
        return "Bad request: \(code)"
    case 500...599:
        return "Server error: \(code)"
    default:
        return "Unknown error: \(code)"
    }
}
