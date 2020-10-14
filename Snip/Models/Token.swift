//
//  Token.swift
//  Snip
//
//  Created by Kirill Beletskiy on 11/10/2020.
//  Copyright © 2020 kirqe. All rights reserved.
//

import Foundation

// save to prefs
// https://stackoverflow.com/questions/54849118/how-to-save-a-json-token-to-user-defaults-and-then-use-it-in-a-different-view-s
// https://stackoverflow.com/questions/31923410/save-variable-after-my-app-closes-swift
// https://www.hackingwithswift.com/read/12/overview

//let winStreak = "Streak"
//
//func writeStreak() {
//    let defaults = NSUserDefaults.standardUserDefaults()
//    defaults.setInteger(0, forKey: winStreak)
//    
//}
//
//func readStreak() {
//    let defaults = NSUserDefaults.standardUserDefaults()
//    if let name = defaults.stringForKey(winStreak)
//    {
//        println(name)
//    }
//}

// Application Access Token (pubclic requests, no user data)
struct ApplicationAccessToken: Decodable {
    var accessToken: String?
    var expiresIn: Int?
    var tokenType: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case tokenType = "token_type"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.accessToken = try? container.decode(String.self, forKey: .accessToken)
        self.expiresIn = try? container.decode(Int.self, forKey: .expiresIn)
        self.tokenType = try? container.decode(String.self, forKey: .tokenType)

    }
}

// fix this
func getApplicationAccessToken() {
    let defaults = UserDefaults.standard
    var keys: NSDictionary?
    var clientId: String?
    var clientSecret: String?
    
    if let path = Bundle.main.path(forResource: "App", ofType: "plist") {
        keys = NSDictionary(contentsOfFile: path)
    }
    if let dict = keys {
        clientId = dict["ClientId"] as? String
        clientSecret = dict["ClientSecret"] as? String


    }
    
    let headers = [
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Basic \(Data("\(clientId!):\(clientSecret!)".utf8).base64EncodedString())"
    ]
    
        let httpBody = "grant_type=client_credentials&scope=https%3A%2F%2Fapi.ebay.com%2Foauth%2Fapi_scope".data(using: .utf8)!
    
    dataRequest(with: "https://api.ebay.com/identity/v1/oauth2/token", httpMethod: "POST", headers: headers, httpBody: httpBody, objectType: ApplicationAccessToken.self) { (result: Result) in
        
        
        switch result {
            case .success(let object):
                print(object.expiresIn)
//                defaults.se
                defaults.set(object.accessToken, forKey: "applicationAccessToken")
                defaults.set(object.expiresIn, forKey: "applicationAccessTokenExpiresIn")
                
            case .failure(let error):
                print(error)
        }
    
    }
    
}



// User Access Token"
struct UserAccessToken: Decodable {
    var accessToken: String?
    var expiresIn: Int?
    var refreshToken: String?
    var refreshTokenExpiresIn: Int?
    var tokenType: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case refreshTokenExpiresIn = "refresh_token_expires_in"
        case tokenType = "token_type"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.accessToken = try? container.decode(String.self, forKey: .accessToken)
        self.expiresIn = try? container.decode(Int.self, forKey: .expiresIn)
        self.refreshToken = try? container.decode(String.self, forKey: .refreshToken)
        self.refreshTokenExpiresIn = try? container.decode(Int.self, forKey: .refreshTokenExpiresIn)
        self.tokenType = try? container.decode(String.self, forKey: .tokenType)
    }
}

// fix this
func getUserAccessTokenWith(code: String) {
    let defaults = UserDefaults.standard
    var keys: NSDictionary?
    var clientId: String?
    var clientSecret: String?
    var redirectUri: String?
    
    if let path = Bundle.main.path(forResource: "App", ofType: "plist") {
        keys = NSDictionary(contentsOfFile: path)
    }
    if let dict = keys {
        clientId = dict["ClientId"] as? String
        clientSecret = dict["ClientSecret"] as? String
        redirectUri = dict["RedirectUri"] as? String


    }
    let headers = [
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Basic \(Data("\(clientId!):\(clientSecret!)".utf8).base64EncodedString())"
    ]
    let httpBody = "grant_type=authorization_code&code=\(code)&redirect_uri=\(redirectUri!)".data(using: .utf8)!
    
    dataRequest(with: "https://api.ebay.com/identity/v1/oauth2/token", httpMethod: "POST", headers: headers, httpBody: httpBody, objectType: UserAccessToken.self) { (result: Result) in
        
        
        switch result {
            case .success(let object):
                print(object)
                defaults.set(object.accessToken, forKey: "userAccessToken")
                defaults.set(object.expiresIn, forKey: "userAccessTokenExpiresIn")
                defaults.set(object.refreshToken, forKey: "userAccessTokenRefreshToken")
                defaults.set(object.refreshTokenExpiresIn, forKey: "userAccessTokenRefreshTokenExpiresIn")

            case .failure(let error):
                print(error)
        }
    
    }
    

}
