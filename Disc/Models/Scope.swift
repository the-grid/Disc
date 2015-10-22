import Argo
import Ogra

/// An authorization scope.
public enum Scope: String {
    case Balance = "balance"
    case ContentManagement = "content_management"
    case CTAManagement = "cta_management"
    case GitHubPublic = "github"
    case GitHubPrivate = "github_private"
    case Payment = "payment"
    case Share = "share"
    case UpdateProfile = "update_profile"
    case WebsiteManagement = "website_management"
}


// Mark: - Decodable

extension Scope: Decodable {}


// Mark: - Encodable

extension Scope: Encodable {}
