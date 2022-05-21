//
//  SearchPresenter.swift
//  swifty-companion
//
//  Created by Корогодова Мария Михайловна on 15.05.2022.
//

import Foundation
import AuthenticationServices

final class SearchPresenter {
    
    weak var view: SearchViewInput?
    let interactor: SearchInteractorInput
    let router: SearchRouterInput
    
    init(view: SearchViewInput?,
         interactor: SearchInteractorInput,
         router: SearchRouterInput) {
        
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension SearchPresenter: SearchViewOutput {
    
    func viewDidLoad() {
        
    }
    
    func openProfile() {
        
        // будет только это
//        router.openProfileModule()
        
        guard let signInURL = NetworkRequest.RequestType.signIn.networkRequest()?.url else {

            print("Could not create the sign in URL.")
            return
        }
//        let callbackURLScheme = NetworkRequest.callbackURLScheme
        let scheme = "swifty"
        let authenticationSession = ASWebAuthenticationSession(url: signInURL, callbackURLScheme: scheme) { [weak self] callbackURL, error in
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
            print(code)
            //написать для вью метод
//            self?.view.isLoading = true
            networkRequest.start(responseType: String.self) { result in
              switch result {
              case .success:
                self?.getUser()
              case .failure(let error):
                print("Failed to exchange access code for tokens: \(error)")
              }
            }
        }
        authenticationSession.presentationContextProvider = self.view
        // включить для того, чтобы каждый раз надо было вводить пароль
        authenticationSession.prefersEphemeralWebBrowserSession = true
        if !authenticationSession.start() {
          print("Failed to start ASWebAuthenticationSession")
        }
    }
    
    private func getUser() {
        
        //        isLoading = true
        NetworkRequest
            .RequestType
            .getUser
            .networkRequest()?
            .start(responseType: User.self) { [weak self] result in
                switch result {
                case .success:
                    print("success")
                case .failure(let error):
                    print("Failed to get user, or there is no valid/active session: \(error)")
                }
                //                self?.isLoading = false
            }
    }
}
extension SearchPresenter: SearchInteractorOutput {}
