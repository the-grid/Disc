import Argo
import Ogra

public struct AccessToken {
    public let value: String
    
    public init(value: String) {
        self.value = value
    }
}


// Mark: - Decodable

extension AccessToken: Decodable {
    public static func decode(j: JSON) -> Decoded<AccessToken> {
        return self.init <^> j <| "access_token"
    }
}


// Mark: - Encodable

extension AccessToken: Encodable {
    public func encode() -> JSON {
        return .Object([
            "access_token": value.encode()
        ])
    }
}


// Mark: - Equatable

extension AccessToken: Equatable {}

public func == (lhs: AccessToken, rhs: AccessToken) -> Bool {
    return lhs.value == rhs.value
}
