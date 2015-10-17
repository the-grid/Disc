import Argo
import Ogra

public struct Token {
    let username: String
    let value: String
    
    public init(username: String, value: String) {
        self.username = username
        self.value = value
    }
}


// Mark: - Decodable

extension Token: Decodable {
    public static func decode(j: JSON) -> Decoded<Token> {
        return curry(self.init)
            <^> j <| "username"
            <*> j <| "token"
    }
}


// Mark: - Encodable

extension Token: Encodable {
    public func encode() -> JSON {
        return .Object([
            "username": username.encode(),
            "token": value.encode()
        ])
    }
}


// Mark: - Equatable

extension Token: Equatable {}

public func == (lhs: Token, rhs: Token) -> Bool {
    return lhs.username == rhs.username
        && lhs.value == rhs.value
}
