//
//  TabBarController.swift
//  swifty-companion
//
//  Created by Корогодова Мария Михайловна on 11.06.2022.
//

import UIKit

final class TabBarController: UITabBarController {
    
    private enum TabBarItem: Int {
        
        case profile
        case eval
        case event
        case search
        
        var title: String {
            
            switch self {
                
            case .profile: return "Профиль"
            case .eval: return "Проверки"
            case .event: return "Мероприятия"
            case .search: return "Поиск"
            }
        }
        
        var iconName: String {
    
            switch self {
                
            case .profile: return "person.crop.circle"
            case .eval: return "checkmark.bubble"
            case .event: return "calendar.badge.clock"
            case .search: return "magnifyingglass.circle"
            }
        }
    }
    override func viewDidLoad() {

            super.viewDidLoad()

            self.setupTabBar()

        }
    private func setupTabBar() {
        
        let dataSource: [TabBarItem] = [.profile, .eval, .event, .search]
        
        self.viewControllers = dataSource.map {
            
            switch $0 {
                
            case .profile:
                let vc = ProfileBuilder().build()
                return self.wrappedInNavigationController(with: vc, title: $0.title)
                
            case .eval:
                let vc = EvalViewController()
                return self.wrappedInNavigationController(with: vc, title: $0.title)
    
            case .event:
                let vc = EventsViewController()
                return self.wrappedInNavigationController(with: vc, title: $0.title)
                
            case .search:
                let vc = SearchBuilder().build()
                return self.wrappedInNavigationController(with: vc, title: $0.title)
            }
            
        }
        
        self.viewControllers?.enumerated().forEach {
            
            $1.tabBarItem.title = dataSource[$0].title
            $1.tabBarItem.image = UIImage(systemName: dataSource[$0].iconName)
            $1.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: .zero, bottom: -5, right: .zero)
            
        }
        
    }
    
    private func wrappedInNavigationController(with: UIViewController, title: Any?) -> UINavigationController {

            return UINavigationController(rootViewController: with)
    }
}
