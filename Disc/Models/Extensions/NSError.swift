private let discDomain = "io.thegrid.Disc"
public let NetworkErrorDataKey = discDomain + ".errorData"

extension NSError {
    static func error(message: String, function: String = #function, file: String = #file, line: Int = #line) -> NSError {
        var info = userInfoFor(function, file, line)
        
        info[NSLocalizedDescriptionKey] = message
        
        return NSError(domain: discDomain, code: 0, userInfo: info)
    }
    
    static func error(statusCode: Int, data: AnyObject?, function: String = #function, file: String = #file, line: Int = #line) -> NSError {
        var info = userInfoFor(function, file, line)
        
        info[NSLocalizedDescriptionKey] = messageForStatusCode(statusCode)
        info[NetworkErrorDataKey] = data
        
        return NSError(domain: discDomain, code: statusCode, userInfo: info)
    }
}

private func userInfoFor(function: String, _ file: String, _ line: Int) -> [String: AnyObject] {
    return [
        "\(discDomain).function": function,
        "\(discDomain).file": file,
        "\(discDomain).line": line,
    ]
}

private func messageForStatusCode(code: Int) -> String {
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