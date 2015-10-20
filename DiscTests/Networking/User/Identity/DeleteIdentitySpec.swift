import Disc
import Mockingjay
import Nimble
import Quick
import Result

class DeleteIdentitySpec: QuickSpec {
    override func spec() {
        describe("deleting an identity") {
            it("should result in success") {
                let token = "token"
                let passport = APIClient(token: token)
                
                let identity = Identity(
                    bio: "Bear with me...what is a website. Al is helping out, good guy Al.",
                    description: "Identity only",
                    id: "1234",
                    imageUrl: NSURL(string: "https://pbs.twimg.com/profile_images/519492195351408641/vwSKyJtJ_400x400.jpeg")!,
                    location: "The Woods",
                    provider: .Twitter,
                    url: NSURL(string: "https://twitter.com/grid_bear")!,
                    username: "grid_bear"
                )
                
                let matcher = api(.GET, "https://passport.thegrid.io/api/user/identities/remove/\(identity.id)", token)
                let builder = http(204)
                self.stub(matcher, builder: builder)
                
                
                var responseValue: Void?
                var responseError: NSError?
                
                passport.deleteIdentity(identity) { result in
                    responseValue = result.value
                    responseError = result.error
                }
                
                expect(responseValue).toEventually(beNil())
                expect(responseError).toEventually(beNil())
            }
        }
    }
}
