import Argo
import Disc
import Nimble
import Ogra
import Quick

class ScopeSpec: QuickSpec {
    override func spec() {
        describe("raw values") {
            describe("balance") {
                it("should have the correct raw value") {
                    expect(Scope.Balance.rawValue).to(equal("balance"))
                }
            }
            
            describe("content management") {
                it("should have the correct raw value") {
                    expect(Scope.ContentManagement.rawValue).to(equal("content_management"))
                }
            }
            
            describe("content management") {
                it("should have the correct raw value") {
                    expect(Scope.CTAManagement.rawValue).to(equal("cta_management"))
                }
            }
            
            describe("GitHub (public)") {
                it("should have the correct raw value") {
                    expect(Scope.GitHubPublic.rawValue).to(equal("github"))
                }
            }
            
            describe("GitHub (private)") {
                it("should have the correct raw value") {
                    expect(Scope.GitHubPrivate.rawValue).to(equal("github_private"))
                }
            }
            
            describe("payment") {
                it("should have the correct raw value") {
                    expect(Scope.Payment.rawValue).to(equal("payment"))
                }
            }
            
            describe("share") {
                it("should have the correct raw value") {
                    expect(Scope.Share.rawValue).to(equal("share"))
                }
            }
            
            describe("update profile") {
                it("should have the correct raw value") {
                    expect(Scope.UpdateProfile.rawValue).to(equal("update_profile"))
                }
            }
            
            describe("website management") {
                it("should have the correct raw value") {
                    expect(Scope.WebsiteManagement.rawValue).to(equal("website_management"))
                }
            }
        }
        
        describe("decoding") {           
            it("should produce a Scope") {
                let rawValue = "update_profile"
                let json = JSON.String(rawValue)
                guard let decoded = Scope.decode(json).value else {
                    return XCTFail("Unable to decode JSON: \(json)")
                }
                let scope = Scope(rawValue: rawValue)
                expect(decoded).to(equal(scope))
            }
        }
        
        describe("encoding") {
            it("should produce JSON") {
                let rawValue = "update_profile"
                let scope = Scope(rawValue: rawValue)
                let encoded = scope.encode()
                let json = JSON.String(rawValue)
                expect(encoded).to(equal(json))
            }
        }
    }
}
