import Argo
import Ogra

/// An identity provider.
public enum Provider: String {
    case Facebook = "facebook"
    case Google = "google"
    case GitHub = "github"
    case GitHubPublic = "github_public"
    case GitHubPrivate = "github_private"
    case Twitter = "twitter"
    case Email = "email"
}


// Mark: - Decodable

extension Provider: Decodable {}


// Mark: - Encodable

extension Provider: Encodable {}
