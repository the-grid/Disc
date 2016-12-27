import Argo
import Ogra
import Runes

/// A user.
public struct User {
    public let app: UUID?
    public let avatarUrl: URL?
    public var emailAddress: String
    public let id: UUID
    public var name: String
    public let scopes: [Scope]?
    
    public init(
        app: UUID? = nil,
        avatarUrl: URL? = nil,
        emailAddress: String,
        id: UUID,
        name: String,
        scopes: [Scope]? = nil
    ) {
        self.app = app
        self.avatarUrl = avatarUrl
        self.emailAddress = emailAddress
        self.id = id
        self.name = name
        self.scopes = scopes
    }
}


// Mark: - Decodable

extension User: Decodable {
    public static func decode(_ j: JSON) -> Decoded<User> {
        return curry(self.init)
            <^> j <|?  "app"
            <*> j <|?  "avatar"
            <*> j <|   "email"
            <*> j <|   "uuid"
            <*> j <|   "name"
            <*> j <||? "scope"
    }
}


// Mark: - Encodable

extension User: Encodable {
    public func encode() -> JSON {
        return .object([
            "app": app.encode(),
            "avatar": avatarUrl.encode(),
            "email": emailAddress.encode(),
            "uuid": id.encode(),
            "name": name.encode(),
            "scope": scopes.encode()
        ])
    }
}


// Mark: - Equatable

extension User: Equatable {}

public func == (lhs: User, rhs: User) -> Bool {
    return lhs.app?.uuidString == rhs.app?.uuidString
        && lhs.avatarUrl?.absoluteString == rhs.avatarUrl?.absoluteString
        && lhs.emailAddress == rhs.emailAddress
        && lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.scopes == rhs.scopes
}
