import Disc
import Mockingjay
import MockingjayMatchers
import Nimble
import Quick
import Result

class GetIdentitySpec: QuickSpec {
    override func spec() {
        describe("getting an identity") {
            it("should result in an identity") {
                let token = "token"
                let passport = APIClient(token: token)
                
                let bio = "Bear with me...what is a website. Al is helping out, good guy Al."
                let description = "Identity only"
                let id = 1234
                let imageUrl = "https://pbs.twimg.com/profile_images/519492195351408641/vwSKyJtJ_normal.jpeg"
                let location = "The Woods"
                let provider = "twitter"
                let url = "https://twitter.com/grid_bear"
                let username = "grid_bear"
                
                let responseBody = [
                    "bio": bio,
                    "description": description,
                    "id": id,
                    "image": imageUrl,
                    "location": location,
                    "provider": provider,
                    "url": url,
                    "username": username
                ]
                
                let identity = Identity(
                    bio: bio,
                    description: description,
                    id: id,
                    imageUrl: NSURL(string: imageUrl)!,
                    location: location,
                    provider: Provider(rawValue: provider)!,
                    url: NSURL(string: url)!,
                    username: username
                )
                
                let matcher = api(.GET, "https://passport.thegrid.io/api/user/identities/\(id)", token: token)
                let builder = json(responseBody)
                self.stub(matcher, builder: builder)
                
                var responseValue: Identity?
                var responseError: SwishError?
                
                passport.getIdentity(id) { result in
                    responseValue = result.value
                    responseError = result.error
                }
                
                expect(responseValue).toEventually(equal(identity))
                expect(responseError).toEventually(beNil())
            }
        }
    }
}
