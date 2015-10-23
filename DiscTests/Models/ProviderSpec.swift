import Argo
import Disc
import Nimble
import Ogra
import Quick

class ProviderSpec: QuickSpec {
    override func spec() {
        describe("raw values") {
            describe("Facebook") {
                it("should have the correct raw value") {
                    expect(Provider.Facebook.rawValue).to(equal("facebook"))
                }
            }
            
            describe("GitHub") {
                it("should have the correct raw value") {
                    expect(Provider.GitHub.rawValue).to(equal("github"))
                }
            }
            
            describe("GitHub (public)") {
                it("should have the correct raw value") {
                    expect(Provider.GitHubPublic.rawValue).to(equal("github_public"))
                }
            }
            
            describe("GitHub (private)") {
                it("should have the correct raw value") {
                    expect(Provider.GitHubPrivate.rawValue).to(equal("github_private"))
                }
            }
            
            describe("Google") {
                it("should have the correct raw value") {
                    expect(Provider.Google.rawValue).to(equal("google"))
                }
            }
            
            describe("Twitter") {
                it("should have the correct raw value") {
                    expect(Provider.Twitter.rawValue).to(equal("twitter"))
                }
            }
        }
        
        describe("decoding") {
            it("should produce a Provider") {
                let rawValue = "github"
                let json = JSON.String(rawValue)
                guard let decoded = Provider.decode(json).value else {
                    return XCTFail("Unable to decode JSON: \(json)")
                }
                let provider = Provider(rawValue: rawValue)
                expect(decoded).to(equal(provider))
            }
        }
        
        describe("encoding") {
            it("should produce JSON") {
                let rawValue = "github"
                let provider = Provider(rawValue: rawValue)
                let encoded = provider.encode()
                let json = JSON.String(rawValue)
                expect(encoded).to(equal(json))
            }
        }
    }
}
