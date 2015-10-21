import Argo
import Disc
import Nimble
import Quick

class AccessTokenSpec: QuickSpec {
    override func spec() {
        let value = "token"
        
        let json: JSON = .Object([
            "access_token": .String(value)
        ])
        
        let token = AccessToken(value: value)
        
        describe("decoding") {
            it("should produce an AccessToken") {
                guard let decoded = AccessToken.decode(json).value else {
                    return XCTFail("Unable to decode JSON: \(json)")
                }
                expect(decoded).to(equal(token))
            }
        }
        
        describe("encoding") {
            it("should produce JSON") {
                let encoded = token.encode()
                expect(encoded).to(equal(json))
            }
        }
    }
}
