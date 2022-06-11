//
//  EventsViewController.swift
//  swifty-companion
//
//  Created by Корогодова Мария Михайловна on 11.06.2022.
//

import UIKit

final class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let event: [Event] = {
        [
            Event(name: "Поэтический вечер", date: "29 июня\n18:30", place: "переговорка 224 и онлайн"),
            Event(name: "Встреча книжного клуба", date: "1 июля\n17:30", place: "online и переговорка 224"),
            Event(name: "ft_containers: лекция", date: "10 июл\n15:00", place: "online и переговорка 224 "),
            Event(name: "Introduction to quantum computing", date: "11 июля\n12:30", place: "online"),
            Event(name: "Встреча для 4 волны", date: "20 июля\n16:00", place: "атриум"),
            Event(name: "Мафия", date: "1 августа\n21:00", place: "переговорка 224")
        ]
    }()
    
    
    lazy var tableView: UITableView = {
        
        let table = UITableView()
        
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        table.delegate = self
        table.dataSource = self
        
        return table
    }()
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupView() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(self.tableView)
        setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell

        cell.dateLabel.text = event[indexPath.section].date
        cell.nameLabel.text = event[indexPath.section].name
        cell.placeLabel.text = event[indexPath.section].place
        
        cell.layer.borderColor = UIColor.systemGray5.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 16

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        event.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 300
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("You tapped cell number \(indexPath.section).")
    }
}
