//
//  ProfileViewController.swift
//  swifty-companion
//
//  Created by Корогодова Мария Михайловна on 15.05.2022.
//

import UIKit

enum CoalitionName: String {
    
    case capybara
    case alpaca
    case honeyBadger
    case salamander
    case other
}

//enum CoalitionColor: UIColor {
    
//    switch self {
//
//    case capybara: return .red
//    case alpaca: return .green
//    case honeyBadger: return .blue
//    case salamander: return .violet
//    default: return .grey
//    }
//}

class ProfileViewController: UIViewController {
    
    var presenter: ProfileViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {

        view.backgroundColor = .systemBackground
        
    }
    
}

extension ProfileViewController: ProfileViewInput {}
