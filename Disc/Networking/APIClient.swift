import Foundation
import Swish

let baseURL = "https://passport.thegrid.io/api/"

public struct APIClient {
    let client = Swish.APIClient()
    let token: String
    
    public init(token: String) {
        self.token = token
    }
}
