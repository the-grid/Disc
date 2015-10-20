import Argo
import Ogra

public struct User {
    public let app: NSUUID?
    public let avatarUrl: NSURL?
    public var emailAddress: String
    public let id: NSUUID
    public var name: String
    public let scopes: [Scope]?
    
    public init(
        app: NSUUID? = nil,
        avatarUrl: NSURL? = nil,
        emailAddress: String,
        id: NSUUID,
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
    public static func decode(j: JSON) -> Decoded<User> {
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
        return .Object([
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
    return lhs.app?.UUIDString == rhs.app?.UUIDString
        && lhs.avatarUrl?.absoluteString == rhs.avatarUrl?.absoluteString
        && lhs.emailAddress == rhs.emailAddress
        && lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.scopes == rhs.scopes
}
