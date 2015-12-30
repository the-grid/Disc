import Disc
import Mockingjay
import Nimble
import Quick
import Result

class GetAccessTokenSpec: QuickSpec {
    override func spec() {
        describe("getting an access token") {
            it("should result in an access token") {
                let clientId = "id"
                let clientSecret = "secret"
                let code = "code"
                
                let requestBody = [
                    "client_id": clientId,
                    "client_secret": clientSecret,
                    "code": code,
                    "grant_type": "authorization_code"
                ]
                
                let value = "token"
                
                let responseBody = [
                    "access_token": value
                ]
                
                let token = AccessToken(value: value)

                let url = "https://passport.thegrid.io/login/authorize/token"
                
                let matcher = api(.POST, url, body: requestBody)
                let builder = json(responseBody)
                self.stub(matcher, builder: builder)
                
                var responseValue: AccessToken?
                var responseError: NSError?
                
                APIClient.getAccessToken(clientId: clientId, clientSecret: clientSecret, code: code) { result in
                    responseValue = result.value
                    responseError = result.error
                }
                
                expect(responseValue).toEventually(equal(token))
                expect(responseError).toEventually(beNil())
            }
        }
    }
}
