//
//  SearchRouter.swift
//  swifty-companion
//
//  Created by Корогодова Мария Михайловна on 15.05.2022.
//

import UIKit

final class SearchRouter {
    
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController? = nil) {
        
        self.viewController = viewController
    }
    
}

extension SearchRouter: SearchRouterInput {

    func openProfileModule() {
        
        let module = ProfileBuilder().build()
        viewController?.navigationController?.pushViewController(module, animated: true)
    }
    
    func closeModule() {
        
        viewController?.navigationController?.popViewController(animated: true)
    }
}
