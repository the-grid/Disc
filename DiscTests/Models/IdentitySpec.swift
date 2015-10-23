import Argo
import Disc
import Nimble
import Quick

class IdentitySpec: QuickSpec {
    override func spec() {
        let bio = "Bear with me...what is a website. Al is helping out, good guy Al."
        let description = "Identity only"
        let id = 1234
        let imageUrl = NSURL(string: "https://pbs.twimg.com/profile_images/519492195351408641/vwSKyJtJ_normal.jpeg")!
        let location = "The Woods"
        let provider = Provider.Twitter
        let removable = true
        let url = NSURL(string: "https://twitter.com/grid_bear")!
        let username = "grid_bear"
        
        let json: JSON = .Object([
            "bio": bio.encode(),
            "description": description.encode(),
            "id": id.encode(),
            "image": imageUrl.encode(),
            "location": location.encode(),
            "provider": provider.encode(),
            "canRemove": removable.encode(),
            "url": url.encode(),
            "username": username.encode()
        ])
        
        let identity = Identity(
            bio: bio,
            description: description,
            id: id,
            imageUrl: imageUrl,
            location: location,
            provider: provider,
            removable: removable,
            url: url,
            username: username
        )
        
        describe("decoding") {
            it("should produce an Identity") {
                guard let decoded = Identity.decode(json).value else {
                    return XCTFail("Unable to decode JSON: \(json)")
                }
                expect(decoded).to(equal(identity))
            }
        }
        
        describe("encoding") {
            it("should produce JSON") {
                let encoded = identity.encode()
                expect(encoded).to(equal(json))
            }
        }
    }
}
