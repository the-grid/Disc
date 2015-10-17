import Argo
import Disc
import Nimble
import Quick

class UserSpec: QuickSpec {
    override func spec() {
        let app = "296c2686-92d1-45ad-8ce8-6e8bdb8611d5"
        let avatarUrl = "https://s.gravatar.com/avatar/6a12a226806bb77aa45dac4133d76227"
        let emailAddress = "bear@thegrid.io"
        let id = "f03c6cf1-74ce-4c01-b8fe-cef0f2443e46"
        let name = "Grid Bear"
        let scopes = [ "update_profile" ]
        
        let json: JSON = .Object([
            "app": .String(app),
            "avatar": .String(avatarUrl),
            "email": .String(emailAddress),
            "name": .String(name),
            "uuid": .String(id),
            "scope": .Array(scopes.map(JSON.String))
        ])
        
        let user = User(
            app: NSUUID(UUIDString: app),
            avatarUrl: NSURL(string: avatarUrl),
            emailAddress: emailAddress,
            id: NSUUID(UUIDString: id)!,
            name: name,
            scopes: scopes.map { Scope(rawValue: $0)! }
        )
        
        describe("decoding") {
            it("should produce a User") {
                guard let decoded = User.decode(json).value else {
                    return XCTFail("Unable to decode JSON: \(json)")
                }
                expect(decoded).to(equal(user))
            }
        }
        
        describe("encoding") {
            it("should produce JSON") {
                let encoded = user.encode()
                expect(encoded).to(equal(json))
            }
        }
    }
}
