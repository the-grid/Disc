import Disc
import Mockingjay
import Nimble
import Quick
import Result

class GetUserSpec: QuickSpec {
    override func spec() {
        describe("getting a user") {
            context("current user") {
                it("should result in a user") {
                    let token = "token"
                    let passport = APIClient(token: token)
                    
                    let app = "296c2686-92d1-45ad-8ce8-6e8bdb8611d5"
                    let avatarUrl = "https://s.gravatar.com/avatar/6a12a226806bb77aa45dac4133d76227"
                    let emailAddress = "bear@thegrid.io"
                    let id = "f03c6cf1-74ce-4c01-b8fe-cef0f2443e46"
                    let name = "Grid Bear"
                    let scopes = [ "update_profile" ]
                    
                    let responseBody = [
                        "app": app,
                        "avatar": avatarUrl,
                        "email": emailAddress,
                        "uuid": id,
                        "name": name,
                        "scope": scopes
                    ]
                    
                    let user = User(
                        app: NSUUID(UUIDString: app),
                        avatarUrl: NSURL(string: avatarUrl),
                        emailAddress: emailAddress,
                        id: NSUUID(UUIDString: id)!,
                        name: name,
                        scopes: scopes.map { Scope(rawValue: $0)! }
                    )
                    
                    let matcher = api(.GET, "https://passport.thegrid.io/api/user", token: token)
                    let builder = json(responseBody)
                    self.stub(matcher, builder: builder)

                    var responseValue: User?
                    var responseError: NSError?
                    
                    passport.getUser { result in
                        responseValue = result.value
                        responseError = result.error
                    }

                    expect(responseValue).toEventually(equal(user))
                    expect(responseError).toEventually(beNil())
                }
            }
            
            context("by ID") {
                it("should result in a user") {
                    let token = "token"
                    let passport = APIClient(token: token)
                    
                    let avatarUrl = "https://s.gravatar.com/avatar/6a12a226806bb77aa45dac4133d76227"
                    let emailAddress = "bear@thegrid.io"
                    let id = "f03c6cf1-74ce-4c01-b8fe-cef0f2443e46"
                    let name = "Grid Bear"
                    
                    let responseBody = [
                        "avatar": avatarUrl,
                        "email": emailAddress,
                        "uuid": id,
                        "name": name,
                    ]
                    
                    let user = User(
                        avatarUrl: NSURL(string: avatarUrl),
                        emailAddress: emailAddress,
                        id: NSUUID(UUIDString: id)!,
                        name: name
                    )
                    
                    let matcher = api(.GET, "https://passport.thegrid.io/api/user/\(id)", token: token)
                    let builder = json(responseBody)
                    self.stub(matcher, builder: builder)
                    
                    var responseUser: User?
                    var responseError: NSError?
                    
                    passport.getUser(id) { result in
                        responseUser = result.value
                        responseError = result.error
                    }
                    
                    expect(responseUser).toEventually(equal(user))
                    expect(responseError).toEventually(beNil())
                }
            }
        }
    }
}
