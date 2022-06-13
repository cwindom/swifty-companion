//
//  SearchViewController.swift
//  swifty-companion
//
//  Created by Maria Korogodova on 16.11.2021.
//

import UIKit
import AuthenticationServices

class SearchViewController: UIViewController {
    
    var presenter: SearchViewOutput?
    private(set) var isLoading = false
    
    private let profileImage: UIImageView = {

        let profileImage = UIImageView(image: UIImage(named: "intra_logo"))
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.contentMode = .scaleAspectFit
        profileImage.clipsToBounds = true

        return profileImage
    }()
    
    // сделать две вью: одну на случай авторизованного пользователя с поиском и кнопкой, вторую  на случай неавторизованного пользователя с кнопкой авторизоваться
    // включать их в зависимости от ответа oauth2
    private let textField: UITextField = {
        
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray.cgColor
        
        textField.placeholder = "поиск"
        
        return textField
    }()
    
    private let searchButton: UIButton = {
        
        let searchButton = UIButton(type: .system)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        searchButton.setTitle("найти", for: .normal)
        searchButton.setTitleColor(.grey, for: .normal)
        searchButton.backgroundColor = .event
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        return searchButton
    }()
    
    override func viewDidLoad() {
        
        setupView()
        
        presenter?.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        textField.text = ""
        super.viewWillDisappear(animated)
    }
    
    private func setupView() {
        
        view.backgroundColor = .systemBackground
        view.addSubview(profileImage)
        view.addSubview(textField)
        view.addSubview(searchButton)
        NSLayoutConstraint.activate([
            profileImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -64),
            profileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textField.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 8),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.widthAnchor.constraint(equalToConstant: 200),
            textField.heightAnchor.constraint(equalToConstant: 32),
            searchButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8),
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 200),
            searchButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    @objc func searchButtonTapped() {
        
        let profile: Profile
        let contatcs: Contacts
        let projects: [Project]
        
        switch textField.text {
        case "": break
        case "Cwindom":
            projects = [
                Project(name: "webserv", date: "4 месяца назад", mark: "100"),
                Project(name: "internship 1", date: "5 месяцев назад", mark: "115"),
                Project(name: "piscine swift", date: "7 месяцев назад", mark: "100"),
                Project(name: "ft_printf", date: "8 месяцев назад", mark: "101"),
                Project(name: "exam rank 03", date: "10 месяцев назад", mark: "125"),
                Project(name: "philosophers", date: "10 месяцев назад", mark: "100"),
                Project(name: "minishell", date: "10 месяцев назад", mark: "100"),
                Project(name: "exam rank 02", date: "1 год назад", mark: "125"),
                Project(name: "libasm", date: "1 год назад", mark: "100"),
                Project(name: "cub3d", date: "1 год назад", mark: "103"),
                Project(name: "exam rank01", date: "2 года назад", mark: "100"),
                Project(name: "ft_server", date: "2 года назад", mark: "111"),
                Project(name: "exam rank 00", date: "2 года назад", mark: "103"),
                Project(name: "netwhat", date: "2 года назад", mark: "100")
            ]
            contatcs = Contacts(phone: "+7(906)151-25-50", mail: "cwindom@student.21-school.ru")
            profile = Profile(name: "Cwindom",
                              fullName: "Card Windom",
                              level: 12,
                              availability: "Anavailable",
                              wallet: "wallet: 812 ₳",
                              points: "evaluation points: 24",
                              projects: nil,
                              contacts: contatcs)
            goToProfile(profile: profile)
        case "Gvelva":
            projects = [
                Project(name: "pipex", date: "1 месяц назад", mark: "100"),
                Project(name: "irc", date: "1 месяц назад", mark: "110"),
                Project(name: "piscine java", date: "1 месяц назад", mark: "100"),
                Project(name: "ft_printf", date: "2 месяца назад", mark: "103"),
                Project(name: "exam rank 01", date: "3 месяца назад", mark: "101"),
                Project(name: "philosophers", date: "4 месяца назад", mark: "100"),
                Project(name: "minishell", date: "5 месяцев назад", mark: "100"),
                Project(name: "exam rank 00", date: "5 месяцев назад", mark: "100"),
                Project(name: "libasm", date: "5 месяцев назад", mark: "100"),
                Project(name: "cub3d", date: "1 год назад", mark: "100"),
                Project(name: "netwhat", date: "2 года назад", mark: "100")
            ]
            contatcs = Contacts(phone: "+7(906)316-31-44", mail: "gvelva@student.21-school.ru")
            profile = Profile(name: "Gvelva",
                              fullName: "Gamgee Velva",
                              level: 12,
                              availability: "at-h6",
                              wallet: "wallet: 155 ₳",
                              points: "evaluation points: 3",
                              projects: projects,
                              contacts: contatcs)
            goToProfile(profile: profile)
        case "Wphylici":
            projects = [
                Project(name: "ft_ls", date: "1 месяц назад", mark: "125"),
                Project(name: "fract-ol", date: "1 месяц назад", mark: "110"),
                Project(name: "corewar", date: "2 месяца назад", mark: "125"),
                Project(name: "lem-in", date: "3 месяца назад", mark: "110"),
                Project(name: "exam rank 01", date: "5 месяцев назад", mark: "125"),
                Project(name: "philosophers", date: "5 месяцев назад", mark: "125"),
                Project(name: "inseption", date: "6 месяцев назад", mark: "125"),
                Project(name: "exam rank 00", date: "1 год назад", mark: "125"),
                Project(name: "libasm", date: "1 год назад", mark: "115"),
                Project(name: "cub3d", date: "1 год назад", mark: "125"),
                Project(name: "netwhat", date: "1 года назад", mark: "120")
            ]
            contatcs = Contacts(phone: "+7(903)475-42-02", mail: "wphylici@student.21-school.ru")
            profile = Profile(name: "Wphylici",
                              fullName: "Whitney Phylicia",
                              level: 12,
                              availability: "Anavailable",
                              wallet: "wallet: 10 ₳",
                              points: "evaluation points: -1",
                              projects: projects,
                              contacts: contatcs)
            goToProfile(profile: profile)
        case "Glormell":
            projects = [
                Project(name: "guimp", date: "3 месяца назад", mark: "120"),
                Project(name: "piscine ocaml", date: "7 месяцев назад", mark: "115"),
                Project(name: "piscine ruby", date: "9 месяцев назад", mark: "120"),
                Project(name: "snow crush", date: "9 месяцев назад", mark: "120"),
                Project(name: "in the shadow", date: "12 месяцев назад", mark: "120"),
                Project(name: "linear regression", date: "12 месяцев назад", mark: "125"),
                Project(name: "swifty-companion", date: "12 месяцев назад", mark: "125"),
                Project(name: "swifty-proteins", date: "1 год назад", mark: "115"),
                Project(name: "taskmaster", date: "2 года назад", mark: "115"),
                Project(name: "music room", date: "2 года назад", mark: "110"),
                Project(name: "swift piscine", date: "3 года назад", mark: "120")
            ]
            contatcs = Contacts(phone: "-", mail: "glormell@student.21-school.ru")
            profile = Profile(name: "Glormell",
                              fullName: "Gloria Mellan",
                              level: 12,
                              availability: "ox-g5",
                              wallet: "wallet: 10 ₳",
                              points: "evaluation points: -2",
                              projects: projects,
                              contacts: contatcs)
            goToProfile(profile: profile)
        case "Ksiren":
            projects = [
                Project(name: "pipex", date: "2 месяца назад", mark: "100"),
                Project(name: "irc", date: "3 месяца назад", mark: "100"),
                Project(name: "piscine java", date: "3 месяца назад", mark: "100"),
                Project(name: "ft_printf", date: "4 месяца назад", mark: "100"),
                Project(name: "exam rank 01", date: "6 месяцев назад", mark: "100"),
                Project(name: "philosophers", date: "6 месяцев назад", mark: "100"),
                Project(name: "minishell", date: "6 месяцев назад", mark: "100"),
                Project(name: "exam rank 00", date: "1 год назад", mark: "100"),
                Project(name: "libasm", date: "1 год назад", mark: "100"),
                Project(name: "cub3d", date: "1 год назад", mark: "100"),
                Project(name: "netwhat", date: "1 год назад", mark: "100")
            ]
            contatcs = Contacts(phone: "-", mail: "ksiren@student.21-school.ru")
            profile = Profile(name: "Ksiren",
                              fullName: "Kenia Siren",
                              level: 12,
                              availability: "Anavailable",
                              wallet: "wallet: 330 ₳",
                              points: "evaluation points: 0",
                              projects: projects,
                              contacts: contatcs)
            goToProfile(profile: profile)
        case "Mizola":
            projects = [
                Project(name: "webserv", date: "7 месяцев назад", mark: "107"),
                Project(name: "irc", date: "7 месяцев назад", mark: "110"),
                Project(name: "music room", date: "10 месяцев назад", mark: "125"),
                Project(name: "open project", date: "1 год назад", mark: "125"),
                Project(name: "exam rank 04", date: "1 год назад", mark: "100"),
                Project(name: "philosophers", date: "1 год назад", mark: "125"),
                Project(name: "minishell", date: "1 год назад", mark: "125"),
                Project(name: "exam rank 03", date: "1 год назад", mark: "100"),
                Project(name: "exam rank 02", date: "1 год назад", mark: "100"),
                Project(name: "exam rank 01", date: "1 год назад", mark: "100"),
                Project(name: "exam rank 00", date: "1 год назад", mark: "100")
            ]
            contatcs = Contacts(phone: "-", mail: "mizola@student.21-school.ru")
            profile = Profile(name: "Mizola",
                              fullName: "Menoetius Izola",
                              level: 12,
                              availability: "ox-g3",
                              wallet: "wallet: 0 ₳",
                              points: "evaluation points: 99",
                              projects: projects,
                              contacts: contatcs)
            goToProfile(profile: profile)
        case "Drina":
            projects = [
                Project(name: "pipex", date: "2 месяца назад", mark: "115"),
                Project(name: "irc", date: "3 месяца назад", mark: "110"),
                Project(name: "piscine java", date: "4 месяца назад", mark: "125"),
                Project(name: "ft_printf", date: "4 месяца назад", mark: "125"),
                Project(name: "exam rank 01", date: "4 месяца назад", mark: "115"),
                Project(name: "philosophers", date: "5 месяцев назад", mark: "125"),
                Project(name: "minishell", date: "5 месяцев назад", mark: "125"),
                Project(name: "exam rank 00", date: "6 месяцев назад", mark: "125"),
                Project(name: "libasm", date: "6 месяцев назад", mark: "115"),
                Project(name: "cub3d", date: "6 месяцев назад", mark: "125"),
                Project(name: "netwhat", date: "7 месяцев назад", mark: "125")
            ]
            contatcs = Contacts(phone: "-", mail: "drina@student.21-school.ru")
            profile = Profile(name: "Drina",
                              fullName: "Dalene Rina",
                              level: 12,
                              availability: "Anavailable",
                              wallet: "wallet: 100 ₳",
                              points: "evaluation points: 5",
                              projects: projects,
                              contacts: contatcs)
            goToProfile(profile: profile)
        default:
            showAlert()
        }
        
    }
    
    func goToProfile(profile: Profile) {
        let vc = SearchProfileBuilder().build(profile: profile)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAlert() {
        
        let alert = UIAlertController(title: "Ник не найден", message: "Введите существующее имя пользвателя", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension SearchViewController: SearchViewInput {
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        
      return ASPresentationAnchor()
    }
}
