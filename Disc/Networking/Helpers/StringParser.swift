import Result
import Swish

struct StringParser: Parser {
    typealias Representation = String
    
    static func parse(_ j: AnyObject) -> Result<String, SwishError> {
        guard let data = j as? NSData else {
            let error = NSError.error("Bad data!")
            return .failure(.urlSessionError(error))
        }
        guard let string = String(data: data as Data, encoding: String.Encoding.utf8) else {
            let error = NSError.error("Couldn't NSData convert to string!")
            return .failure(.urlSessionError(error))
        }
        return .success(string)
    }
}
