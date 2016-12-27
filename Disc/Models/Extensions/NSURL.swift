import Argo
import Foundation
import Ogra


// Mark: - Decodable

extension URL: Decodable {
    public typealias DecodedType = URL
    
    public static func decode(_ json: JSON) -> Decoded<URL> {
        switch json {
        case .string(let s):
          if let res = URL(string: s).map(pure) {
            return res
          }
          return .typeMismatch(expected: "URL", actual: json)
        default:
            return .typeMismatch(expected: "URL", actual: json)
        }
    }
}


// Mark: - Encodable

extension URL: Encodable {
    public func encode() -> JSON {
        return absoluteString.encode()
    }
}
