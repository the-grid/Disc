import Result
import Swish

struct StringDeserializer: Deserializer {
    func deserialize(_ data: Data?) -> Result<AnyObject, SwishError> {
        guard let data = data , data.count > 0 else {
            return .success(NSNull())
        }
        
        return .success(data as AnyObject)
    }
}
