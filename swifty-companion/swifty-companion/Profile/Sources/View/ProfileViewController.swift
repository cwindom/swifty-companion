//
//  ProfileViewController.swift
//  swifty-companion
//
//  Created by Корогодова Мария Михайловна on 15.05.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var presenter: ProfileViewOutput?
    
    override func viewDidLoad() {
        
        setupView()
    }
    
    private func setupView() {

        view.backgroundColor = .red
    }

}

extension ProfileViewController: ProfileViewInput {}
