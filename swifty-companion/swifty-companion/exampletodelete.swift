//
//  exampletodelete.swift
//  swifty-companion
//
//  Created by Корогодова Мария Михайловна on 16.02.2022.
//

import UIKit

struct UserInfoModel {
    var email: String
    var login: String
    var displayName: String
    var imageData: Data?
    var correctionPoint: Int
    var wallet: Int
    var campusName: String
}

struct CursusData {
    var level: Double
    var skills: [Skills]
    var cursus: Cursus
    var projects: [ProjectsUsers]
}

final class UserInfoPresenter {
    func dataConfigure(_ data: UserData) -> (UserInfoModel, [CursusData]) {
        let userInfoModel = UserInfoModel(
                email: data.email,
                login: data.login,
                displayName: data.displayName,
                imageData: data.imageData,
                correctionPoint: data.correctionPoint,
                wallet: data.wallet,
                campusName: data.campus.first?.name ?? "Unknown"
            )
        var cursusData = [CursusData]()
        
        data.cursusUsers.forEach { cursus in
            var projects = [ProjectsUsers]()
            
            data.projectsUsers.forEach { project in
                if project.cursusIds.contains(cursus.cursus.id) {
                    projects.append(project)
                }
            }
            
            let course = CursusData(
                    level: cursus.level,
                    skills: cursus.skills,
                    cursus: cursus.cursus,
                    projects: projects
            )
            cursusData.append(course)
        }
        
        return (userInfoModel, cursusData)
    }
}

final class UserInfoViewController: UITableViewController {
    
    private var presenter: UserInfoPresenter!
    
    private enum HeightHeader {
        static let userInfoHeader: CGFloat = 293
        static let defaultHeader: CGFloat = 59
    }
    
    private enum HeightRow {
        static let projectRow: CGFloat = 51
        static let skillRow: CGFloat = 70
    }
    
    // MARK: - Properties
    
    private var userData: UserData!
    private var additionalData: UserInfoModel!
    private var cursusData: [CursusData]!
    private var currentCursus: CursusData!

    // MARK: - Init
    
    init(userData: UserData) {
        self.userData = userData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPresenter()
        setupTableView()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Таким способом НавБар начинает отображатсья сразу
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        // Таким способом НавБар начинает сразу скрыватсья
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: Constants.Assets.background)!)
        
        navigationItem.title = additionalData.login.uppercased()
    }
    
    private func setupTableView() {
        tableView.register(ProjectTableViewCell.self, forCellReuseIdentifier: ProjectTableViewCell.id)
        tableView.register(SkillTableViewCell.self, forCellReuseIdentifier: SkillTableViewCell.id)
    }
    
    private func setupPresenter() {
        presenter = UserInfoPresenter()
        
        (additionalData, cursusData) = presenter.dataConfigure(userData)
        currentCursus = cursusData.first
    }
    
    private func userInfoHeaderConfigure() -> UserInfoHeader {
        let view = UserInfoHeader()
        if let imageData = additionalData.imageData {
            view.imageView.image = UIImage(data: imageData)
        }
        
        view.displayName.text = additionalData.displayName
        view.wallet.text = "Wallet: \(additionalData.wallet)"
        view.evaluationPoints.text = "Evaluation points: \(additionalData.correctionPoint)"
        view.mailLabel.text = additionalData.email
        view.campusLabel.text = additionalData.campusName

        let levelIntLiteral = currentCursus.level.rounded(.down)
        let levelHundredsInt = (currentCursus.level - levelIntLiteral) * 100
        view.levelLabel.text = "level \(Int(levelIntLiteral)) - \(Int(levelHundredsInt.rounded()))%"

        view.progressViewLevel.progress = Float(levelHundredsInt) / 100
        view.cursusButton.setTitle(currentCursus.cursus.name, for: .normal)
        
        view.buttonAction = {
            let ac = UIAlertController(title: "Select cursus", message: nil, preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.cursusData.forEach { cursusData in
                ac.addAction(UIAlertAction(
                                title: cursusData.cursus.name,
                                style: .default,
                                handler: { _ in
                                    self.currentCursus = cursusData
                                    UIView.transition(
                                        with: self.tableView,
                                        duration: 0.35,
                                        options: .transitionCrossDissolve,
                                        animations: { self.tableView.reloadData() })
                                }))
            }
            self.present(ac, animated: true, completion: nil)
        }
        return view
    }
    
    private func projectHeaderConfigure() -> DefaultHeaderView {
        let view = DefaultHeaderView()
        view.label.text = "Projects"
        return view
    }
    
    private func skillsHeaderConfugure() -> DefaultHeaderView {
        let view = DefaultHeaderView()
        view.label.text = "Skills"
        return view
    }
    
    private func projectCellConfigure(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProjectTableViewCell.id, for: indexPath) as! ProjectTableViewCell
        
        cell.label.text = currentCursus.projects[indexPath.row].project.name
        guard currentCursus.projects[indexPath.row].finalMark != nil else {
            cell.markLabel.isHidden = true
            cell.clockImage.isHidden = false
            return cell
        }
        cell.markLabel.text = String(currentCursus.projects[indexPath.row].finalMark!)

        let color = currentCursus.projects[indexPath.row].validated == true ? UIColor.green : .red
        cell.markLabel.textColor = color
        
        cell.clockImage.isHidden = true
        cell.markLabel.isHidden = false
        return cell
    }
    
    private func skillCellConfigure(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SkillTableViewCell.id, for: indexPath) as! SkillTableViewCell
        
        cell.label.text = currentCursus.skills[indexPath.row].name
        cell.marklabel.text = String(format: "%.2f", currentCursus.skills[indexPath.row].level)
        let progress = currentCursus.skills[indexPath.row].level / 20
        cell.progressView.progress = Float(progress)
        return cell
    }
}

// MARK: - TableView Data Source
extension UserInfoViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return userInfoHeaderConfigure()
        case 1:
            return projectHeaderConfigure()
        case 2:
            return skillsHeaderConfugure()
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0
            ? HeightHeader.userInfoHeader
            : HeightHeader.defaultHeader
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return currentCursus.projects.count
        case 2:
            return currentCursus.skills.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1:
            return HeightRow.projectRow
        case 2:
            return HeightRow.skillRow
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            return projectCellConfigure(tableView, at: indexPath)
        case 2:
            return skillCellConfigure(tableView, at: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension UIColor {
    static let transColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 0.65)
}
