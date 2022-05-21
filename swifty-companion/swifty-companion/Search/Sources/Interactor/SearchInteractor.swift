//
//  SearchInteractor.swift
//  swifty-companion
//
//  Created by Корогодова Мария Михайловна on 15.05.2022.
//

import Foundation
import AuthenticationServices

final class SearchInteractor {
    
    weak var output: SearchInteractorOutput?
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        
        self.networkService = networkService
    }
}

extension SearchInteractor: SearchInteractorInput {}
