import Argo
import Ogra

/// An access token.
public struct AccessToken {
    /// The value that was passed to `init`.
    public let value: String
    
    /// Create an access token with the provided `value`.
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
