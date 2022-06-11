//
//  EvalViewController.swift
//  swifty-companion
//
//  Created by Корогодова Мария Михайловна on 11.06.2022.
//

import UIKit

final class EvalViewController: UIViewController {
    
    public lazy var imageView: UIImageView = {
        
        let imageView = UIImageView(image: UIImage(named: "answers"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    public lazy var titleLabel: UILabel = {
        
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textAlignment = .center
        view.text = "Нет запланированных проверок."
        
        return view
    }()
    
    public lazy var subtitleLabel: UILabel = {
        
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textAlignment = .center
        view.text = "Чтобы записаться на проверку, нужно иметь хотя бы один законченный проект."
        
        return view
    }()
    
    public lazy var textStackView: UIStackView = {
        
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 2
        stackView.layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(textStackView)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -64),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 64),
            textStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            textStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textStackView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
    }
}
