import Argo
import Disc
import Nimble
import Quick

class TokenSpec: QuickSpec {
    override func spec() {
        let username = "gridbear"
        let value = "nijcoqf3h3287f7g"
        
        let json: JSON = .Object([
            "username": .String(username),
            "token": .String(value)
        ])
        
        let token = Token(username: username, value: value)
        
        describe("decoding") {
            it("should produce a Token") {
                guard let decoded = Token.decode(json).value else {
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
