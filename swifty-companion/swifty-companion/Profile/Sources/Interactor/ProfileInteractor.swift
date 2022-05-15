//
//  ProfileInteractor.swift
//  swifty-companion
//
//  Created by Корогодова Мария Михайловна on 15.05.2022.
//

import Foundation

final class ProfileInteractor {
    
    weak var output: ProfileInteractorOutput?
}

extension ProfileInteractor: ProfileInteractorInput {}
