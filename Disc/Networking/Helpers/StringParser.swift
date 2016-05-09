import Result
import Swish

struct StringParser: Parser {
    typealias Representation = String
    
    static func parse(j: AnyObject) -> Result<String, SwishError> {
        guard let data = j as? NSData else {
            let error = NSError.error("Bad data!")
            
            return .Failure(.InvalidJSONResponse(error))
        }
        
        let error = NSError.error("Couldn't convert to string!")
        let string = String(data: data, encoding: NSUTF8StringEncoding)
        
        return Result(string, failWith: .InvalidJSONResponse(error))
    }
}