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
        searchButton.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 177/255, alpha: 1.0)
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        return searchButton
    }()
    
    override func viewDidLoad() {
        
        setupView()
        
        presenter?.viewDidLoad()
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
        
        presenter?.openProfile()
    }
}

extension SearchViewController: SearchViewInput {
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        
      return ASPresentationAnchor()
    }
}
