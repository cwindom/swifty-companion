//
//  TableViewCell.swift
//  swifty-companion
//
//  Created by Корогодова Мария Михайловна on 11.06.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    /// Название мероприятия
    var nameLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.minimumScaleFactor = 1.0
        
        return label
    }()
    
    var placeLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.minimumScaleFactor = 1.0
        
        return label
    }()
    
    var dateLabel: UITextView = {
        
        let label = UITextView()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.isEditable = false
        label.widthAnchor.constraint(equalToConstant: 64).isActive = true
        label.backgroundColor = .event
        
        return label
    }()
    
    lazy var mainStackView: UIStackView = {
        
        var stackView = UIStackView(arrangedSubviews: [dateLabel, labelStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    lazy var labelStackView: UIStackView = {
        
        var stackView = UIStackView(arrangedSubviews: [nameLabel, placeLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
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
        
       super.init(style: style, reuseIdentifier: "TableViewCell")
        setUp()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
