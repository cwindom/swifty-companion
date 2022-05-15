//
//  ProfileRouter.swift
//  swifty-companion
//
//  Created by Корогодова Мария Михайловна on 15.05.2022.
//

import UIKit

final class ProfileRouter {
    
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController? = nil) {
        
        self.viewController = viewController
    }
    
}

extension ProfileRouter: ProfileRouterInput {
    
    
}
