import Result
import Swish

struct StringDeserializer: Deserializer {
    func deserialize(data: NSData?) -> Result<AnyObject, SwishError> {
        guard let data = data where data.length > 0 else {
            return .Success(NSNull())
        }
        
        return .Success(data)
    }
}