//
//  SearchPresenter.swift
//  swifty-companion
//
//  Created by Корогодова Мария Михайловна on 15.05.2022.
//

import Foundation

final class SearchPresenter {
    
    weak var view: SearchViewInput?
    let interactor: SearchInteractorInput
    let router: SearchRouterInput
    
    init(view: SearchViewInput?,
         interactor: SearchInteractorInput,
         router: SearchRouterInput) {
        
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension SearchPresenter: SearchViewOutput {
    
    func openProfile() {
        
        router.openProfileModule()
    }
}
extension SearchPresenter: SearchInteractorOutput {}
