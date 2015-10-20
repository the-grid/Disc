import Disc
import Mockingjay
import Nimble
import Quick
import Result

class GetPublicGitHubTokenSpec: QuickSpec {
    override func spec() {
        describe("getting a public GitHub token") {
            it("should result in a GitHub token") {
                let passportToken = "token"
                let passport = APIClient(token: passportToken)
                
                let username = "gridbear"
                let value = "nijcoqf3h3287f7g"
                
                let responseBody = [
                    "username": username,
                    "token": value
                ]

                let githubToken = GitHubToken(username: username, value: value)
                
                let matcher = api(.GET, "https://passport.thegrid.io/api/user/github", passportToken)
                let builder = json(responseBody)
                self.stub(matcher, builder: builder)
                
                var responseValue: GitHubToken?
                var responseError: NSError?
                
                passport.getPublicGitHubToken() { result in
                    responseValue = result.value
                    responseError = result.error
                }
                
                expect(responseValue).toEventually(equal(githubToken))
                expect(responseError).toEventually(beNil())
            }
        }
    }
}
