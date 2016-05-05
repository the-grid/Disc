import Result
import Swish

struct StringDeserializer: Deserializer {
    func deserialize<T : Request>(request: T) -> (NSData?) -> Result<T.ResponseParser.Representation, SwishError> {
        return { (data: AnyObject?) -> Result<T.ResponseParser.Representation, SwishError> in
            let string = self.parseString(data)
            switch string {
            case let .Failure(e):
                return .Failure(.URLSessionError(e))
            case let .Success(j):
                return .Success(T.ResponseParser.parse(j))
            }
        }
    }
}

private extension StringDeserializer {
    private func parseString(data: AnyObject?) -> Result<String, NSError> {
        guard let d = data as? String else {
            return .Success("")
        }
        return .Success(d)
    }
}