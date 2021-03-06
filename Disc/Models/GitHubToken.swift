import Argo
import Ogra
import Runes

/// A GitHub token.
public struct GitHubToken {
    public let username: String
    public let value: String
    
    public init(username: String, value: String) {
        self.username = username
        self.value = value
    }
}


// Mark: - Decodable

extension GitHubToken: Decodable {
    public static func decode(_ j: JSON) -> Decoded<GitHubToken> {
        return curry(self.init)
            <^> j <| "username"
            <*> j <| "token"
    }
}


// Mark: - Encodable

extension GitHubToken: Encodable {
    public func encode() -> JSON {
        return .object([
            "username": username.encode(),
            "token": value.encode()
        ])
    }
}


// Mark: - Equatable

extension GitHubToken: Equatable {}

public func == (lhs: GitHubToken, rhs: GitHubToken) -> Bool {
    return lhs.username == rhs.username
        && lhs.value == rhs.value
}
