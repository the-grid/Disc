import Argo
import Ogra

/// An access token.
public struct AccessToken {
    /// The value that was passed to `init`.
    public let accessToken: String
    public let refreshToken: String?
    
    /// Create an access token with the provided `value`.
    public init(
        accessToken: String,
        refreshToken: String?
    ) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}

// Mark: - Decodable

extension AccessToken: Decodable {
    public static func decode(j: JSON) -> Decoded<AccessToken> {
        return curry(self.init)
            <^> j <| "access_token"
            <*> j <|? "refresh_token"
    }
}


// Mark: - Encodable

extension AccessToken: Encodable {
    public func encode() -> JSON {
        return .Object([
            "access_token": accessToken.encode(),
            "refresh_token": refreshToken.encode()
        ])
    }
}


// Mark: - Equatable

extension AccessToken: Equatable {}

public func == (lhs: AccessToken, rhs: AccessToken) -> Bool {
    return lhs.accessToken == rhs.accessToken && lhs.refreshToken == rhs.refreshToken
}
