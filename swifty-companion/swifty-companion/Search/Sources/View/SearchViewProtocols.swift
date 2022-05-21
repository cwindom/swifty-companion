//
//  SearchViewProtocols.swift
//  swifty-companion
//
//  Created by Корогодова Мария Михайловна on 15.05.2022.
//

import Foundation
import AuthenticationServices

protocol SearchViewInput: AnyObject, ASWebAuthenticationPresentationContextProviding {
    
}

protocol SearchViewOutput {
    
    func openProfile()
    func viewDidLoad()
}
