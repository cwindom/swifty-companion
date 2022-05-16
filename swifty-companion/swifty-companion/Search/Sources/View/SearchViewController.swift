//
//  SearchViewController.swift
//  swifty-companion
//
//  Created by Maria Korogodova on 16.11.2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    var presenter: SearchViewOutput?
    
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
        presenter?.openProfile()
    }
}

extension SearchViewController: SearchViewInput {}
