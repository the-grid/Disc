import Disc
import Mockingjay
import Nimble
import Quick
import Result

class GetAccessTokenSpec: QuickSpec {
    override func spec() {
        describe("getting an access token") {
            var clientId: String!
            
            var value: String!
            var responseBody: [String: String]!
            
            var token: AccessToken!
            
            beforeEach {
                clientId = "id"
                
                value = "token"
                
                responseBody = [
                    "access_token": value
                ]
                
                token = AccessToken(value: value)
            }
            
            context("with a Passport auth code") {
                it("should result in an access token") {
                    let clientSecret = "secret"
                    let code = "code"
                    
                    let requestBody = [
                        "client_id": clientId,
                        "client_secret": clientSecret,
                        "code": code,
                        "grant_type": "authorization_code"
                    ]
                    
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
            
            context("with an OAuth provider") {
                var url: String!
                
                var providerAccessToken: String!
                var providerTokenSecret: String!
                
                var providerAuthCode: String!
                var providerRedirectUri: String!
                
                var provider: Provider!
                var scopes: [Scope]!
                
                beforeEach {
                    url = "https://passport.thegrid.io/api/auth/login"
                    
                    providerAccessToken = "provider access token"
                    providerTokenSecret = "provider token secret"
                    
                    providerAuthCode = "provider auth code"
                    providerRedirectUri = "provider redirect URI"
                    
                    provider = .Twitter
                    scopes = [ .ContentManagement, .UpdateProfile ]
                }
                
                context("access token") {
                    context("without scopes") {
                        it("should result in an access token") {
                            let requestBody = [
                                "client_id": clientId,
                                "provider": provider.rawValue,
                                "token": providerAccessToken,
                            ]
                            
                            let matcher = api(.POST, url, body: requestBody)
                            let builder = json(responseBody)
                            self.stub(matcher, builder: builder)
                            
                            var responseValue: AccessToken?
                            var responseError: NSError?
                            
                            APIClient.getAccessToken(clientId: clientId, provider: provider, token: providerAccessToken) { result in
                                responseValue = result.value
                                responseError = result.error
                            }
                            
                            expect(responseValue).toEventually(equal(token))
                            expect(responseError).toEventually(beNil())
                        }
                    }
                    
                    context("with scopes") {
                        it("should result in an access token") {
                            let requestBody: [String: AnyObject] = [
                                "client_id": clientId,
                                "provider": provider.rawValue,
                                "scope": "\(scopes.first!.rawValue),\(scopes.last!.rawValue)",
                                "token": providerAccessToken
                            ]
                            
                            let matcher = api(.POST, url, body: requestBody)
                            let builder = json(responseBody)
                            self.stub(matcher, builder: builder)
                            
                            var responseValue: AccessToken?
                            var responseError: NSError?
                            
                            APIClient.getAccessToken(clientId: clientId, scopes: scopes, provider: provider, token: providerAccessToken) { result in
                                responseValue = result.value
                                responseError = result.error
                            }
                            
                            expect(responseValue).toEventually(equal(token))
                            expect(responseError).toEventually(beNil())
                        }
                    }
                }
                
                context("access token and secret") {
                    context("without scopes") {
                        it("should result in an access token") {
                            let requestBody = [
                                "client_id": clientId,
                                "provider": provider.rawValue,
                                "token": providerAccessToken,
                                "token_secret": providerTokenSecret
                            ]
                            
                            let matcher = api(.POST, url, body: requestBody)
                            let builder = json(responseBody)
                            self.stub(matcher, builder: builder)
                            
                            var responseValue: AccessToken?
                            var responseError: NSError?
                            
                            APIClient.getAccessToken(clientId: clientId, provider: provider, token: providerAccessToken, secret: providerTokenSecret) { result in
                                responseValue = result.value
                                responseError = result.error
                            }
                            
                            expect(responseValue).toEventually(equal(token))
                            expect(responseError).toEventually(beNil())
                        }
                    }
                    
                    context("with scopes") {
                        it("should result in an access token") {
                            let requestBody: [String: AnyObject] = [
                                "client_id": clientId,
                                "provider": provider.rawValue,
                                "scope": "\(scopes.first!.rawValue),\(scopes.last!.rawValue)",
                                "token": providerAccessToken,
                                "token_secret": providerTokenSecret
                            ]
                            
                            let matcher = api(.POST, url, body: requestBody)
                            let builder = json(responseBody)
                            self.stub(matcher, builder: builder)
                            
                            var responseValue: AccessToken?
                            var responseError: NSError?
                            
                            APIClient.getAccessToken(clientId: clientId, scopes: scopes, provider: provider, token: providerAccessToken, secret: providerTokenSecret) { result in
                                responseValue = result.value
                                responseError = result.error
                            }
                            
                            expect(responseValue).toEventually(equal(token))
                            expect(responseError).toEventually(beNil())
                        }
                    }
                }
                
                context("auth code and redirect URI") {
                    context("without scopes") {
                        it("should result in an access token") {
                            let requestBody = [
                                "client_id": clientId,
                                "provider": provider.rawValue,
                                "code": providerAuthCode,
                                "redirect_uri": providerRedirectUri
                            ]
                            
                            let matcher = api(.POST, url, body: requestBody)
                            let builder = json(responseBody)
                            self.stub(matcher, builder: builder)
                            
                            var responseValue: AccessToken?
                            var responseError: NSError?
                            
                            APIClient.getAccessToken(clientId: clientId, provider: provider, code: providerAuthCode, redirectUri: providerRedirectUri) { result in
                                responseValue = result.value
                                responseError = result.error
                            }
                            
                            expect(responseValue).toEventually(equal(token))
                            expect(responseError).toEventually(beNil())
                        }
                    }
                    
                    context("with scopes") {
                        it("should result in an access token") {
                            let requestBody: [String: AnyObject] = [
                                "client_id": clientId,
                                "code": providerAuthCode,
                                "provider": provider.rawValue,
                                "redirect_uri": providerRedirectUri,
                                "scope": "\(scopes.first!.rawValue),\(scopes.last!.rawValue)"
                            ]
                            
                            let matcher = api(.POST, url, body: requestBody)
                            let builder = json(responseBody)
                            self.stub(matcher, builder: builder)
                            
                            var responseValue: AccessToken?
                            var responseError: NSError?
                            
                            APIClient.getAccessToken(clientId: clientId, scopes: scopes, provider: provider, code: providerAuthCode, redirectUri: providerRedirectUri) { result in
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
    }
}
