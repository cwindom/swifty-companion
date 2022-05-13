//
//  ViewController.swift
//  swifty-companion
//
//  Created by Maria Korogodova on 16.11.2021.
//

import UIKit

/// инфу о коалициях положить в enum и выбирать switch?
///  придумать организацию
//struct CoalitionDesign {
//
//    var logoImage: UIImage
//    var mainColor: UIColor
//    var name: String
//}

//protocol DesignStyle {
//
//    var textColor: UIColor { get set }
//    var logoImage: UIImage { get set }
//    var mainColor: UIColor { get set }
//    var name: String { get set }
//}


final class StyleCapybara {
    
    /// сделать нормальное оформление цветов, причем с поддержкой темной темы
    var mainColor: UIColor = .red
    var logoImage: UIImage
    var name: String
    
    init(mainColor: UIColor, logoImage: UIImage, name: String) {
        self.mainColor = mainColor
        self.logoImage = logoImage
        self.name = name
    }
    
}
//final class StyleAlpaca: DesignStyle {
//    var textColor: UIColor
//    var logoImage: UIImage
//    var mainColor: UIColor
//    var name: String
//}
//final class StyleSalamander: DesignStyle {
//    var textColor: UIColor
//    var logoImage: UIImage
//    var mainColor: UIColor
//    var name: String
//}
//final class StyleHoneyBadger: DesignStyle {
//    var textColor: UIColor
//    var logoImage: UIImage
//    var mainColor: UIColor
//    var name: String
//}

/// для загрузки картинки профиля будет отдельный сервис, а заглушкой будет обычная картинка

class LoginViewController: UIViewController {
    
    private let profileImage: UIImageView = {
        
        let profileImage = UIImageView(image: UIImage(named: "intra_logo"))
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.contentMode = .scaleAspectFit
        
        return profileImage
    }()
    
    private let textField: UITextField = {
        
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.text = "cwindom"
        
        return textField
    }()
    
    private lazy var stackView: UIStackView = {
       
        let stackView = UIStackView(arrangedSubviews: [profileImage, textField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
//        stackView.spacing = 8
        
        return stackView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .red
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
