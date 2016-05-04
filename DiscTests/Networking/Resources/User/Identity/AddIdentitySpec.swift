import Disc
import Mockingjay
import MockingjayMatchers
import Nimble
import Quick
import Result

class AddIdentitySpec: QuickSpec {
    override func spec() {
        describe("adding an identity") {
            var token: String!
            var passport: APIClient!
            
            var providerAccessToken: String!
            var provider: String!
            
            var responseBody: [String: AnyObject]!
            var identity: Identity!
            
            beforeEach {
                token = "token"
                passport = APIClient(token: token)
                
                providerAccessToken = "provider access token"
                
                let bio = "Bear with me...what is a website. Al is helping out, good guy Al."
                let description = "Identity only"
                let id = 1234
                let imageUrl = "https://pbs.twimg.com/profile_images/519492195351408641/vwSKyJtJ_normal.jpeg"
                let location = "The Woods"
                provider = "twitter"
                let url = "https://twitter.com/grid_bear"
                let username = "grid_bear"
                
                responseBody = [
                    "bio": bio,
                    "description": description,
                    "id": id,
                    "image": imageUrl,
                    "location": location,
                    "provider": provider,
                    "url": url,
                    "username": username
                ]
                
                identity = Identity(
                    bio: bio,
                    description: description,
                    id: id,
                    imageUrl: NSURL(string: imageUrl)!,
                    location: location,
                    provider: Provider(rawValue: provider)!,
                    url: NSURL(string: url)!,
                    username: username
                )
            }
            
            context("with only an access token") {
                it("should result in an identity") {
                    let requestBody = [
                        "provider": provider,
                        "token": providerAccessToken
                    ]
                    
                    let matcher = api(.POST, "https://passport.thegrid.io/api/user/identities", token: token, body: requestBody)
                    let builder = json(responseBody)
                    self.stub(matcher, builder: builder)
                    
                    var responseValue: Identity?
                    var responseError: SwishError?
                    
                    passport.addIdentity(identity.provider, token: providerAccessToken) { result in
                        responseValue = result.value
                        responseError = result.error
                    }
                    
                    expect(responseValue).toEventually(equal(identity))
                    expect(responseError).toEventually(beNil())
                }
            }
            
            context("with an access token and secret") {
                it("should result in an identity") {
                    let providerTokenSecret = "provider token secret"
                    
                    let requestBody = [
                        "provider": provider,
                        "token": providerAccessToken,
                        "token_secret": providerTokenSecret
                    ]
                    
                    let matcher = api(.POST, "https://passport.thegrid.io/api/user/identities", token: token, body: requestBody)
                    let builder = json(responseBody)
                    self.stub(matcher, builder: builder)
                    
                    var responseValue: Identity?
                    var responseError: SwishError?
                    
                    passport.addIdentity(identity.provider, token: providerAccessToken, secret: providerTokenSecret) { result in
                        responseValue = result.value
                        responseError = result.error
                    }
                    
                    expect(responseValue).toEventually(equal(identity))
                    expect(responseError).toEventually(beNil())
                }
            }
            
            context("with an auth code and redirect URI") {
                it("should result in an identity") {
                    let authCode = "provider auth code"
                    let redirectUri = "redirect URI"
                    
                    let requestBody = [
                        "provider": provider,
                        "code": authCode,
                        "redirect_uri": redirectUri
                    ]
                    
                    let matcher = api(.POST, "https://passport.thegrid.io/api/user/identities", token: token, body: requestBody)
                    let builder = json(responseBody)
                    self.stub(matcher, builder: builder)
                    
                    var responseValue: Identity?
                    var responseError: SwishError?
                    
                    passport.addIdentity(identity.provider, code: authCode, redirectUri: redirectUri) { result in
                        responseValue = result.value
                        responseError = result.error
                    }
                    
                    expect(responseValue).toEventually(equal(identity))
                    expect(responseError).toEventually(beNil())
                }
            }
        }
    }
}
