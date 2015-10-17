import Argo
import Ogra

public struct Identity {
    let bio: String?
    let description: String
    let id: String
    let imageUrl: NSURL?
    let location: String?
    let provider: Provider
    let url: NSURL
    let username: String
    
    public init(
        bio: String?,
        description: String,
        id: String,
        imageUrl: NSURL?,
        location: String?,
        provider: Provider,
        url: NSURL,
        username: String
    ) {
        self.bio = bio
        self.description = description
        self.id = id
        self.imageUrl = imageUrl
        self.location = location
        self.provider = provider
        self.url = url
        self.username = username
    }
}


// Mark: - Decodable

extension Identity: Decodable {
    public static func decode(j: JSON) -> Decoded<Identity> {
        return curry(self.init)
            <^> j <|? "bio"
            <*> j <|  "description"
            <*> j <|  "id"
            <*> j <|? "image"
            <*> j <|? "location"
            <*> j <|  "provider"
            <*> j <|  "url"
            <*> j <|  "username"
    }
}


// Mark: - Encodable

extension Identity: Encodable {
    public func encode() -> JSON {
        return .Object([
            "bio": bio.encode(),
            "description": description.encode(),
            "id": id.encode(),
            "image": imageUrl.encode(),
            "location": location.encode(),
            "provider": provider.encode(),
            "url": url.encode(),
            "username": username.encode()
        ])
    }
}


// Mark: - Equatable

extension Identity: Equatable {}

public func == (lhs: Identity, rhs: Identity) -> Bool {
    return lhs.bio == rhs.bio
        && lhs.description == rhs.description
        && lhs.id == rhs.id
        && lhs.imageUrl == rhs.imageUrl
        && lhs.location == rhs.location
        && lhs.provider == rhs.provider
        && lhs.url == rhs.url
        && lhs.username == rhs.username
}
