//
//  AuthorizeWindowController.swift
//  Snip
//
//  Created by Kirill Beletskiy on 12/10/2020.
//  Copyright © 2020 kirqe. All rights reserved.
//

import Cocoa
import WebKit

class AuthorizeWindowController: NSWindowController, WKNavigationDelegate {
    
    @IBOutlet weak var authorizeWKView: WKWebView!
    
    var hasCode: Bool = false
    var keys: NSDictionary?
    var clientId: String?
    var clientSecret: String?
    var redirectUri: String?
    
    var stringUrl = ""
    
    convenience init() {
        self.init(windowNibName: "AuthorizeWindowController")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        authorizeWKView.navigationDelegate = self
   
        
        print("lalalala")
//        authorizeWKView.addObserver(self, forKeyPath: "URL", options: .new, context: nil)

        stringUrl = "https://auth.ebay.com/oauth2/authorize?client_id=\(clientId!)&response_type=code&redirect_uri=\(redirectUri!)&scope=https://api.ebay.com/oauth/api_scope https://api.ebay.com/oauth/api_scope/sell.marketing.readonly https://api.ebay.com/oauth/api_scope/sell.marketing https://api.ebay.com/oauth/api_scope/sell.inventory.readonly https://api.ebay.com/oauth/api_scope/sell.inventory https://api.ebay.com/oauth/api_scope/sell.account.readonly https://api.ebay.com/oauth/api_scope/sell.account https://api.ebay.com/oauth/api_scope/sell.fulfillment.readonly https://api.ebay.com/oauth/api_scope/sell.fulfillment https://api.ebay.com/oauth/api_scope/sell.analytics.readonly https://api.ebay.com/oauth/api_scope/sell.finances https://api.ebay.com/oauth/api_scope/sell.payment.dispute https://api.ebay.com/oauth/api_scope/commerce.identity.readonly"
        
        
        if let url = URL(string: stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) {

            authorizeWKView.load(URLRequest(url: url))
            authorizeWKView.allowsBackForwardNavigationGestures = true
        }

        
    }
    

    

    func getQueryStringParameter(url: String, param: String) -> String? {
      guard let url = URLComponents(string: url) else { return nil }
      return url.queryItems?.first(where: { $0.name == param })?.value
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print(webView.url?.absoluteString)
        if authorizeWKView.url!.absoluteString == "https://www.ebay.com/" && hasCode == false {
            let encodedURL = stringUrl //+ scope.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
             if let url = URL(string: encodedURL) {
                authorizeWKView.load(URLRequest(url: url))
                authorizeWKView.allowsBackForwardNavigationGestures = true
            }
  
        }


        

        if let code = getQueryStringParameter(url: webView.url!.absoluteString, param: "code") {

                print(webView.url?.absoluteString)
                hasCode = true
                print("THERES YOUR CODE")
                print(code)
                

                
                print("getUserAccessTokenWith -> ")
                getUserAccessTokenWith(code: code.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
                
//                authorizeWKView.removeFromSuperview()
                window?.close()
//            }

//    }
        
    
    
}



}



}
