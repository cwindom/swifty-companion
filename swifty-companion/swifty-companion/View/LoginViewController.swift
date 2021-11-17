//
//  ViewController.swift
//  swifty-companion
//
//  Created by Maria Korogodova on 16.11.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    var logoImage: UIImageView = {
        
        let logoImage = UIImageView(image: UIImage(named: "intra_logo"))
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.contentMode = .scaleAspectFill
        
        return logoImage
    }()
    
    lazy var stackView: UIStackView = {
        
        var stackView = UIStackView(arrangedSubviews: [logoImage, loginButton])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.setCustomSpacing(64.0, after: logoImage)
        
        return stackView
    }()
    
    lazy var loginButton: UIButton = {
        
        var loginButton = UIButton()
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        let buttonFont = UIFont(name: "FuturaPT-Heavy", size: UIFont.labelFontSize)
        loginButton.titleLabel?.font = UIFontMetrics.default.scaledFont(for: buttonFont!)
        loginButton.titleLabel?.adjustsFontForContentSizeCategory = true
        loginButton.setTitle("SIGN IN", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = UIColor(displayP3Red: 0, green: 0.729, blue: 0.737, alpha: 1.0)
        loginButton.addTarget(self, action: #selector(onLoginClick), for: .touchUpInside)
        
        return loginButton
    }()
    
    func setupBackground() {
        
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        let background = UIImage(named: "background.jpeg")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    func setupView() {
        
        setupBackground()
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50.0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50.0),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100.0),
        ])
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupView()
        
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }

    @IBAction func onLoginClick(_ sender: Any) {
        print("hey")
    }
//    func makeMainViewController() -> UIViewController {
//
//        let oAuthService = OAuthService(oauthClient: LocalOauthClient())
//        let loginVC = LoginViewController(oAuthService: oAuthService)
//        let navigationController = UINavigationController(rootViewController: loginVC)
//        return navigationController
//    }
}
