//
//  SearchInteractor.swift
//  swifty-companion
//
//  Created by Корогодова Мария Михайловна on 15.05.2022.
//

import Foundation

final class SearchInteractor {
    
    weak var output: SearchInteractorOutput?
}

extension SearchInteractor: SearchInteractorInput {}
