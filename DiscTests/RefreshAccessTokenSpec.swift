import Disc
import Mockingjay
import MockingjayMatchers
import Nimble
import Quick
import Result
import Swish

class RefreshAccessTokenSpec: QuickSpec {
    override func spec() {
        describe("getting an access token") {
            var clientId: String!
            var accessToken: String!
            var responseBody: [String: String]!
            var token: AccessToken!
            
            beforeEach {
                clientId = "id"
                accessToken = "token"
                responseBody = [
                    "access_token": accessToken
                ]
                
                token = AccessToken(accessToken: accessToken, refreshToken: .None)
            }
            
            context("with a refresh token") {
                it("should result in an access token") {
                    let refreshToken = "refreshToken"
                    let requestBody = [
                        "client_id": clientId,
                        "refresh_token": refreshToken
                    ]
                    let url = "https://passport.thegrid.io/api/auth/token"
                    
                    let matcher = api(.POST, url, body: requestBody)
                    let builder = json(responseBody)
                    self.stub(matcher, builder: builder)
                    
                    var responseValue: AccessToken?
                    var responseError: SwishError?
                    
                    APIClient.getRefreshToken(clientId: clientId, refreshToken: refreshToken) { result in
                        responseValue = result.value
                        responseError = result.error
                    }
                    
                    expect(responseValue).toEventually(equal(token))
                    expect(responseError).toEventually(beNil())
                }
            }
        }
    }
}