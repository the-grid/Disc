import Disc
import Mockingjay
import MockingjayMatchers
import Nimble
import Quick
import Result
import Swish

class DeleteIdentitySpec: QuickSpec {
    override func spec() {
        describe("deleting an identity") {
            it("should result in success") {
                let token = "token"
                let passport = APIClient(token: token)
                
                let id = 1234
                
                let matcher = api(.DELETE, "https://passport.thegrid.io/api/user/identities/\(id)", token: token)
                let builder = http(204)
                self.stub(matcher, builder: builder)
                
                var responseValue: Void?
                var responseError: SwishError? = NSError(domain: "io.thegrid.Disc", code: 0, userInfo: nil) as? SwishError
                
                passport.deleteIdentity(id) { result in
                    responseValue = result.value
                    responseError = result.error
                }
                
                expect(responseValue).toEventually(beVoid())
                expect(responseError).toEventually(beNil())
            }
        }
    }
}
