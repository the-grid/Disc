import Argo
import Foundation
import Ogra


// Mark: - Decodable

extension NSUUID: Decodable {
    public typealias DecodedType = NSUUID
    
    public static func decode(j: JSON) -> Decoded<NSUUID> {
        switch j {
        case .String(let s):
            return NSUUID(UUIDString: s).map(pure) ?? .typeMismatch("UUID", actual: j)
        default:
            return .typeMismatch("UUID", actual: j)
        }
    }
}


// Mark: - Encodable

extension NSUUID: Encodable {
    public func encode() -> JSON {
        return UUIDString.lowercaseString.encode()
    }
}
