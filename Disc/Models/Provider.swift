import Argo
import Ogra

public enum Provider: String {
    case Facebook = "facebook"
    case Google = "google"
    case GitHub = "github"
    case Twitter = "twitter"
}


// Mark: - Decodable

extension Provider: Decodable {}


// Mark: - Encodable

extension Provider: Encodable {}
