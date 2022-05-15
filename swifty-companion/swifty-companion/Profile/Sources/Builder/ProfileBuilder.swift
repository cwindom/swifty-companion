//
//  ProfileBuilder.swift
//  swifty-companion
//
//  Created by Корогодова Мария Михайловна on 15.05.2022.
//

import Foundation
import UIKit

final class ProfileBuilder {
    
}

extension ProfileBuilder: ProfileBuilderProtocol {
    
    func build() -> UIViewController {
        
        let view = ProfileViewController()
        let interactor = ProfileInteractor()
        let router = ProfileRouter(viewController: view)
        let presenter = ProfilePresenter(view: view,
                                        interactor: interactor,
                                        router: router)
        
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
    
}
