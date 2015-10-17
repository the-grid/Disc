import Argo
import Foundation
import Ogra


// Mark: - Decodable

extension NSURL: Decodable {
    public typealias DecodedType = NSURL
    
    public static func decode(j: JSON) -> Decoded<NSURL> {
        switch j {
        case .String(let s):
            return NSURL(string: s).map(pure) ?? .typeMismatch("URL", actual: j)
        default:
            return .typeMismatch("URL", actual: j)
        }
    }
}


// Mark: - Encodable

extension NSURL: Encodable {
    public func encode() -> JSON {
        return absoluteString.encode()
    }
}
