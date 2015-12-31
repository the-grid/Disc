import Disc
import Nimble
import Quick

class CreateLoginUrlSpec: QuickSpec {
    override func spec() {
        describe("creating a login URL") {
            let clientId = "id"
            let redirectUri = "uri://"
            
            context("not specifying scopes or a provider") {
                it("should result in login URL") {
                    let url = APIClient.createLoginUrl(clientId: clientId, redirectUri: redirectUri)
                    
                    let expectedUrlString = "https://passport.thegrid.io/login/authorize"
                        + "?client_id=\(clientId)"
                        + "&redirect_uri=\(redirectUri)"
                        + "&response_type=code"
                        + "&scope="
                    
                    let expectedUrl = NSURL(string: expectedUrlString)
                    
                    expect(url).to(equal(expectedUrl))
                }
            }
            
            context("specifying a provider without scopes") {
                it("should result in login URL") {
                    let provider: Provider = .GitHub
                    let url = APIClient.createLoginUrl(clientId: clientId, redirectUri: redirectUri, provider: provider)
                    
                    let expectedUrlString = "https://passport.thegrid.io/login/authorize/\(provider.rawValue)"
                        + "?client_id=\(clientId)"
                        + "&redirect_uri=\(redirectUri)"
                        + "&response_type=code"
                        + "&scope="
                    
                    let expectedUrl = NSURL(string: expectedUrlString)
                    expect(url).to(equal(expectedUrl))
                }
            }
            
            context("specifying scopes without a provider") {
                it("should result in login URL") {
                    let scopes: [Scope] = [ .ContentManagement, .UpdateProfile ]
                    let url = APIClient.createLoginUrl(clientId: clientId, redirectUri: redirectUri, scopes: scopes)
                    
                    let expectedUrlString = "https://passport.thegrid.io/login/authorize"
                        + "?client_id=\(clientId)"
                        + "&redirect_uri=\(redirectUri)"
                        + "&response_type=code"
                        + "&scope=\(scopes.first!.rawValue),\(scopes.last!.rawValue)"
                    
                    let expectedUrl = NSURL(string: expectedUrlString)
                    expect(url).to(equal(expectedUrl))
                }
            }
            
            context("specifying scopes and a provider") {
                it("should result in login URL") {
                    let scopes: [Scope] = [ .ContentManagement, .UpdateProfile ]
                    let provider: Provider = .GitHub
                    let url = APIClient.createLoginUrl(clientId: clientId, redirectUri: redirectUri, scopes: scopes, provider: provider)
                    
                    let expectedUrlString = "https://passport.thegrid.io/login/authorize/\(provider.rawValue)"
                        + "?client_id=\(clientId)"
                        + "&redirect_uri=\(redirectUri)"
                        + "&response_type=code"
                        + "&scope=\(scopes.first!.rawValue),\(scopes.last!.rawValue)"
                    
                    let expectedUrl = NSURL(string: expectedUrlString)
                    expect(url).to(equal(expectedUrl))
                }
            }
        }
    }
}
