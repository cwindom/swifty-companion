//
//  ProfilePresenter.swift
//  swifty-companion
//
//  Created by Корогодова Мария Михайловна on 15.05.2022.
//

import Foundation

final class ProfilePresenter {
    
    weak var view: ProfileViewInput?
    let interactor: ProfileInteractorInput
    let router: ProfileRouterInput
    
    init(view: ProfileViewInput?,
         interactor: ProfileInteractorInput,
         router: ProfileRouterInput) {
        
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension ProfilePresenter: ProfileViewOutput {}
extension ProfilePresenter: ProfileInteractorOutput {}
