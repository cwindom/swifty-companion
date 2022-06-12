//
//  ProjectTableViewCell.swift
//  swifty-companion
//
//  Created by Корогодова Мария Михайловна on 12.06.2022.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {
    
    var nameLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.minimumScaleFactor = 1.0
        label.textColor = .event
        label.font = .boldSystemFont(ofSize: 14)
        label.widthAnchor.constraint(equalToConstant: 128).isActive = true
        
        return label
    }()
    
    var dateLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 13)
        
        return label
    }()
    
    var markLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.minimumScaleFactor = 1.0
        label.textColor = .systemGreen
        label.font = .boldSystemFont(ofSize: 14)
        
        return label
    }()
    
    lazy var labelStackView: UIStackView = {
        
        var stackView = UIStackView(arrangedSubviews: [nameLabel, dateLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    lazy var mainStackView: UIStackView = {
        
        var stackView = UIStackView(arrangedSubviews: [labelStackView, markLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    /// Функция устанавливает и настраивает констрейнты.
    func setUp() {
        
        selectionStyle = .none
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
       super.init(style: style, reuseIdentifier: "ProjectTableViewCell")
        setUp()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
