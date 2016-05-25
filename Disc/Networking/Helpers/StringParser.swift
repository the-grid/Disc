import Result
import Swish

struct StringParser: Parser {
    typealias Representation = String
    
    static func parse(j: AnyObject) -> Result<String, SwishError> {
        guard let data = j as? NSData else {
            let error = NSError.error("Bad data!")
            return .Failure(.URLSessionError(error))
        }
        guard let string = String(data: data, encoding: NSUTF8StringEncoding) else {
            let error = NSError.error("Couldn't NSData convert to string!")
            return .Failure(.URLSessionError(error))
        }
        return .Success(string)
    }
}