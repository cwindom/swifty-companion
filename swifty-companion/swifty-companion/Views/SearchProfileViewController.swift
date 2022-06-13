//
//  SearchProfileViewController.swift
//  swifty-companion
//
//  Created by Корогодова Мария Михайловна on 13.06.2022.
//

import UIKit

class SearchProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var profile: Profile?
    
    var walletLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.minimumScaleFactor = 1.0
        
        return label
    }()
    
    var pointsLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.minimumScaleFactor = 1.0
        
        return label
    }()
    
    public lazy var labelStackView: UIStackView = {
        
        let stackView = UIStackView(arrangedSubviews: [
            walletLabel,
            pointsLabel
        ])
        stackView.backgroundColor = .systemBackground
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 2
        stackView.layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    //контакты
    var mailLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.minimumScaleFactor = 1.0
        
        return label
    }()
    
    var phoneLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.minimumScaleFactor = 1.0
        
        return label
    }()
    
    public lazy var contactsStackView: UIStackView = {
        
        let stackView = UIStackView(arrangedSubviews: [
            mailLabel,
            phoneLabel
        ])
        stackView.backgroundColor = .systemBackground
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 2
        stackView.layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    //фото
    private let profileImage: UIImageView = {

        let profileImage = UIImageView(image: UIImage(named: "photo"))
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.contentMode = .scaleAspectFit
        profileImage.clipsToBounds = true
        profileImage.heightAnchor.constraint(equalToConstant: 128).isActive = true

        return profileImage
    }()
    //имя
    var fullNameLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.minimumScaleFactor = 1.0
        label.text = "Card Windom"
        
        return label
    }()
    var availableLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.minimumScaleFactor = 1.0
        label.text = "Unavailable"
        
        return label
    }()
    //город
    var moscowLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.minimumScaleFactor = 1.0
        label.widthAnchor.constraint(equalToConstant: 82).isActive = true
        label.text = "Москва"
        
        return label
    }()
    //дата поступления
    var dateLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.minimumScaleFactor = 1.0
        label.widthAnchor.constraint(equalToConstant: 82).isActive = true
        label.text = "01/20"
        
        return label
    }()
    
    public lazy var imageStackView: UIStackView = {
        
        let stackView = UIStackView(arrangedSubviews: [
            profileImage,
            fullNameLabel,
            availableLabel
        ])
        stackView.backgroundColor = .systemBackground
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 2
        stackView.layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    public lazy var textStackView: UIStackView = {
        
        let stackView = UIStackView(arrangedSubviews: [
            moscowLabel,
            imageStackView,
            dateLabel
        ])
        stackView.backgroundColor = .systemBackground
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .top
        stackView.spacing = 2
        stackView.layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    public lazy var mainStackView: UIStackView = {
        
        let stackView = UIStackView(arrangedSubviews: [
            textStackView,
//            labelStackView,
            contactsStackView
        ])
        stackView.backgroundColor = .systemBackground
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 2
        stackView.layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    lazy var tableView: UITableView = {
        
        let table = UITableView()
        
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ProjectTableViewCell.self, forCellReuseIdentifier: "ProjectTableViewCell")
        table.delegate = self
        table.dataSource = self
        
        return table
    }()
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupView() {
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.event]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.title = profile?.name ?? ""
        view.addSubview(mainStackView)
        view.addSubview(tableView)
        setupConstraints()
    
        walletLabel.text = profile?.wallet
        pointsLabel.text = profile?.points
        fullNameLabel.text = profile?.fullName
        availableLabel.text = profile?.availability
        mailLabel.text = profile?.contacts?.mail
        phoneLabel.text = profile?.contacts?.phone
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectTableViewCell", for: indexPath) as! ProjectTableViewCell
        cell.nameLabel.text = profile?.projects?[indexPath.row].name
        cell.dateLabel.text = profile?.projects?[indexPath.row].date
        cell.markLabel.text = profile?.projects?[indexPath.row].mark
        cell.layer.borderColor = UIColor.systemBackground.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 16

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        profile?.projects?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = UIColor.clear
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.text = "Проекты"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .systemGray
        headerView.addSubview(label)
        
        return headerView
    }
    
}

final class SearchProfileBuilder {
    
    public func build(profile: Profile) -> UIViewController {
        
        let view = SearchProfileViewController()
        view.profile = profile
        
        return view
    }
    
}
