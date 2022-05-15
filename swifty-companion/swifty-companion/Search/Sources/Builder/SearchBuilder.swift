//
//  SearchBuilder.swift
//  swifty-companion
//
//  Created by Корогодова Мария Михайловна on 15.05.2022.
//

import Foundation
import UIKit

final class SearchBuilder {
    
}

extension SearchBuilder: SearchBuilderProtocol {
    
    func build() -> UIViewController {
        
        let view = SearchViewController()
        let interactor = SearchInteractor()
        let router = SearchRouter(viewController: view)
        let presenter = SearchPresenter(view: view,
                                        interactor: interactor,
                                        router: router)
        
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
    
}
