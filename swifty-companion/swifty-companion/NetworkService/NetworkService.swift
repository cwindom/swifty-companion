//
//  NetworkService.swift
//  swifty-companion
//
//  Created by Корогодова Мария Михайловна on 17.05.2022.
//

import Foundation
import AuthenticationServices
import OAuth2

final class NetworkService: NetworkServiceProtocol {
    
    var webAuthSession: ASWebAuthenticationSession?
    
    static let clientID = "5b5e17939a353679df61518bffb9a186da960681aae7932e320efd2aabf62f3d"
    static let clientSecret = "215f5c2da8d2f7ec54104a862eb02f8041a8055472d334e23e186a16244e7b85"
    
    let baseUrl = "api.intra.42.fr"
    
    private func urlComponents(host: String = "api.intra.42.fr", path: String, queryItems: [URLQueryItem]?) -> URLComponents {
//        switch self {
//        default:
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        
        return urlComponents
//        }
    }
    
    @available(iOS 12.0, *)
    func getAuthTokenWithWebLogin() {
        
//        let authURL = URL(string: "https://api.intra.42.fr")
        
        /// авторизация
        let queryItems = [
          URLQueryItem(name: "client_id", value: NetworkRequest.clientID),
          URLQueryItem(name: "redirect_uri", value: "https://profile.intra.42.fr/"),
          URLQueryItem(name: "response_type", value: "code")
        ]
        guard let url = urlComponents(host: "api.intra.42.fr", path: "/oauth/authorize", queryItems: queryItems).url else {
            print("url error")
            return
        }
        
        let scheme = "swifty"
        let authenticationSession = ASWebAuthenticationSession(url: url, callbackURLScheme: scheme) { [weak self] callbackURL, error in
            guard
                error == nil,
                let callbackURL = callbackURL,
                let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems,
                let code = queryItems.first(where: { $0.name == "code" })?.value,
                let networkRequest = NetworkRequest.RequestType.codeExchange(code: code).networkRequest()
            else {
                print("An error occurred when attempting to sign in.")
                return
            }
            //написать для вью метод
//            self?.view.isLoading = true
            networkRequest.start(responseType: String.self) { result in
              switch result {
              case .success:
                  print("success")
//                self?.getUser()
              case .failure(let error):
                print("Failed to exchange access code for tokens: \(error)")
              }
            }
        }
//        authenticationSession.presentationContextProvider = self.view
        // включить для того, чтобы каждый раз надо было вводить пароль
        authenticationSession.prefersEphemeralWebBrowserSession = true
        if !authenticationSession.start() {
          print("Failed to start ASWebAuthenticationSession")
        }
        
        self.webAuthSession = ASWebAuthenticationSession.init(url: url, callbackURLScheme: scheme, completionHandler: { (callBack: URL?, error: Error?) in
            
            // handle auth response
            guard error == nil, let successURL = callBack else {
                return
            }
            
            let oauthToken = NSURLComponents(string: (successURL.absoluteString))?.queryItems?.filter({$0.name == "code"}).first
            
            // Do what you now that you've got the token, or use the callBack URL
            print(oauthToken ?? "No OAuth Token")
        })
        
        // Kick it off
        self.webAuthSession?.start()
    }
}
