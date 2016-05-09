import Argo
import Disc
import Nimble
import Quick

class AccessTokenSpec: QuickSpec {
    override func spec() {
        
        describe("creating an access token") {
            let accessToken = "token"
            let refreshToken = "token"
            
            context("with an access token and refresh token") {
                let json: JSON = .Object([
                    "access_token": .String(accessToken),
                    "refresh_token": .String(refreshToken)
                ])
                
                let token = AccessToken(accessToken: accessToken, refreshToken: refreshToken)
                
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
            
            context("with only a refresh token") {
                let json: JSON = .Object([
                    "access_token": .String(accessToken),
                    "refresh_token": .Null
                ])
                
                let token = AccessToken(accessToken: accessToken, refreshToken: .None)
                
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
    }
}
