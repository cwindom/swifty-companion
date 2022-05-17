//
//  SearchViewController.swift
//  swifty-companion
//
//  Created by Maria Korogodova on 16.11.2021.
//

import UIKit
import AuthenticationServices

class SearchViewController: UIViewController {
    
    var presenter: SearchViewOutput?
    private(set) var isLoading = false
    
    private let profileImage: UIImageView = {
        
        let profileImage = UIImageView(image: UIImage(named: "intra_logo"))
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.contentMode = .scaleAspectFit
        profileImage.clipsToBounds = true
        
        return profileImage
    }()
    
    // сделать две вью: одну на случай авторизованного пользователя с поиском и кнопкой, вторую  на случай неавторизованного пользователя с кнопкой авторизоваться
    // включать их в зависимости от ответа oauth2
    private let textField: UITextField = {
        
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.placeholder = "поиск"
        
        return textField
    }()
    
    private let searchButton: UIButton = {
        
        let searchButton = UIButton(type: .system)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setTitle("найти", for: .normal)
        searchButton.backgroundColor = .green
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        return searchButton
    }()
    
    override func viewDidLoad() {
        
        setupView()
    }
    
    private func setupView() {
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        view.addSubview(profileImage)
        view.addSubview(textField)
        view.addSubview(searchButton)
        NSLayoutConstraint.activate([
            profileImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -64),
            profileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textField.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 8),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.widthAnchor.constraint(equalToConstant: 200),
            searchButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8),
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc func searchButtonTapped() {
        
        print("searchButtonTapped")
//        presenter?.openProfile()
        guard let signInURL = NetworkRequest.RequestType.signIn.networkRequest()?.url else {
            
            print("Could not create the sign in URL .")
            return
        }
        let callbackURLScheme = NetworkRequest.callbackURLScheme
        let authenticationSession = ASWebAuthenticationSession(url: signInURL, callbackURLScheme: callbackURLScheme) { [weak self] callbackURL, error in
            
            guard
                error == nil,
                let callbackURL = callbackURL,
                // 2
                let queryItems = URLComponents(string: callbackURL.absoluteString)?
                    .queryItems,
                // 3
                let code = queryItems.first(where: { $0.name == "code" })?.value,
                // 4
                let networkRequest =
                    NetworkRequest.RequestType.codeExchange(code: code).networkRequest()
            else {
                // 5
                print("An error occurred when attempting to sign in.")
                return
            }
            self?.isLoading = true
            networkRequest.start(responseType: String.self) { result in
              switch result {
              case .success:
                self?.getUser()
              case .failure(let error):
                print("Failed to exchange access code for tokens: \(error)")
              }
            }
        }
        authenticationSession.presentationContextProvider = self
        // включить для того, чтобы каждый раз надо было вводить пароль
        authenticationSession.prefersEphemeralWebBrowserSession = true
        if !authenticationSession.start() {
          print("Failed to start ASWebAuthenticationSession")
        }
    }
    
    private func getUser() {
        
        isLoading = true
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
            self?.isLoading = false
          }
    }
}

extension SearchViewController: SearchViewInput {}

extension SearchViewController: ASWebAuthenticationPresentationContextProviding {
    
  func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
      
    let window = UIApplication.shared.windows.first { $0.isKeyWindow }
    return window ?? ASPresentationAnchor()
  }
}
