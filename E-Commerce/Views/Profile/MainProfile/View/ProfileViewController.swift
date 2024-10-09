//
//  ProfileViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 08/10/2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var presonal_InformationTableView: UITableView!
    @IBOutlet weak var helpCenterTableView: UITableView!
    
    //MARK: - VARIABLES
    private let viewModel = ProfileViewModel()
    
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - @IBACTIONS
    
}

// MARK: - SETUP VIEW

private extension ProfileViewController {
    
    //MARK: - FUNCTIONS
    
    func setupView() {
        setupNavBar()
        setupTableViews()
        registerCells()
    }
    
    func setupNavBar(){
        navBar.setupFirstLeadingButton(with: "", and: UIImage(named: "back")!) {
            print("back")
        }
        navBar.firstTralingButton.isHidden = true
    }
    
    func setupTableViews() {
        presonal_InformationTableView.delegate = self
        presonal_InformationTableView.dataSource = self
        helpCenterTableView.delegate = self
        helpCenterTableView.dataSource = self
        presonal_InformationTableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        helpCenterTableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        
        
    }
    
    func registerCells() {
        presonal_InformationTableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
        helpCenterTableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
    }
}

extension ProfileViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView{
        case presonal_InformationTableView:
            return viewModel.ProfileHeaderTable.count
        case  helpCenterTableView:
            return viewModel.HelpCenterTable.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case presonal_InformationTableView:
            let cell = presonal_InformationTableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
            let personal_Info = viewModel.ProfileHeaderTable[indexPath.row]
            cell.Setup(ProfileCell: personal_Info)
            return cell
            
        case helpCenterTableView:
            let cell = helpCenterTableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
            let personal_Info = viewModel.HelpCenterTable[indexPath.row]
            cell.Setup(ProfileCell: personal_Info)
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == presonal_InformationTableView {
            switch indexPath.row {
            case 0:
                let settingVC = SettingViewController(nibName: "SettingViewController", bundle: nil)
                navigationController?.pushViewController(settingVC, animated: true)
            case 1:
                print("Navigating to NotificationsViewController")
                let notificationsVC = NotificationsViewController(nibName: "NotificationsViewController", bundle: nil)
                navigationController?.pushViewController(notificationsVC, animated: true)
            default:
                print("No action for this row in Personal Information TableView")
            }
        } else if tableView == helpCenterTableView {
            switch indexPath.row {
            case 0:
                print("Navigating to HelpCenterViewController")
                let helpCenterVC = CartViewController(nibName: "CartViewController", bundle: nil)
                navigationController?.pushViewController(helpCenterVC, animated: true)
            default:
                print("No action for this row in Help Center TableView")
            }
        }
    }
}




