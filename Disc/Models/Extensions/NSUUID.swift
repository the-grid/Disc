import Argo
import Foundation
import Ogra


// Mark: - Decodable

extension UUID: Decodable {
    public typealias DecodedType = UUID
    
    public static func decode(_ json: JSON) -> Decoded<UUID> {
      switch json {
      case .string(let s):
        if let result = UUID(uuidString: s).map(pure) {
          return result
        }
        return .typeMismatch(expected: "UUID", actual: json)
      default:
        return .typeMismatch(expected: "UUID", actual: json)
      }
    }
}


// Mark: - Encodable

extension UUID: Encodable {
    public func encode() -> JSON {
        return uuidString.lowercased().encode()
    }
}
