//
//  SettingViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 09/10/2024.
//

import UIKit

class SettingViewController: UIViewController {
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var editImageButton: UIButton!
    @IBOutlet weak var uploadImageButton: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var genderCollectionView: UICollectionView!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var settingTableView: UITableView!
    
    @IBOutlet weak var logoutButton: UIButton!
    //MARK: - VARIABLES
    
    private let viewModel = SettingViewModel()
    var selectedGenderIndex: IndexPath?
    
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - @IBACTIONS
    
    @IBAction func editImageButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func upload_ImageButtonAction(_ sender: Any) {
        
    }
    @IBAction func logoutButtonAction(_ sender: Any) {
    }
}

// MARK: - SETUP VIEW

private extension SettingViewController {
    func setupView() {
        configureNavBar()
        configureCollectionView()
        registerCells()
        configureTableView()
    }
    
    func configureNavBar() {
        navBar.setupFirstLeadingButton(
            with: "",
            and: UIImage(named: "back")!) {
                self.navigationController!.popViewController(animated: true)
            }
        navBar.firstTralingButton.isHidden = true
    }
    
    func configureCollectionView() {
        genderCollectionView.delegate = self
        genderCollectionView.dataSource = self
    }
    
    func configureTableView() {
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
    
    func registerCells() {
        genderCollectionView.register(UINib(nibName: GenderCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: GenderCollectionViewCell.identifier)
        settingTableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
    }
    
}

//MARK: - Extentions

extension SettingViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource {
    
    ///Collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.genders.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return configureGenderCell(for: collectionView, with: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let gender = viewModel.genders[indexPath.row]
        let label = UILabel()
        label.text = gender.gender
        label.font = UIFont.systemFont(ofSize: 14)
        label.sizeToFit()
        let textWidth = label.frame.width + 60
        let textHeight = label.frame.height + 16
        return CGSize(width: textWidth, height: textHeight)
    }
    
    ///Table view
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedGenderIndex = indexPath
        
        collectionView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.settings.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingTableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
        let settings = viewModel.settings[indexPath.row]
        cell.Setup(ProfileCell: settings)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let languageVC = SelectLanguageViewController(nibName: "SelectLanguageViewController", bundle: nil)
            navigationController?.pushViewController(languageVC, animated: true)
        case 1:
            let notificationsVC = NotificationsControllViewController(nibName: "NotificationsControllViewController", bundle: nil)
            navigationController?.pushViewController(notificationsVC, animated: true)
        case 2:
            let darkModeVC = DarkModeViewController(nibName: "DarkModeViewController", bundle: nil)
            navigationController?.pushViewController(darkModeVC, animated: true)
        default:
            print("No action for this row in Personal Information TableView")
        }
        
    }
}

private extension SettingViewController {
    func configureGenderCell(for collectionView: UICollectionView, with indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenderCollectionViewCell.identifier, for: indexPath) as! GenderCollectionViewCell
        let gender = viewModel.genders[indexPath.row]
        cell.gender.text = gender.gender
        if selectedGenderIndex == indexPath {
            cell.mainView.backgroundColor = .black
            cell.gender.textColor = .white
            cell.mainView.borderColor = .black
            cell.mainView.borderWidth = 1
            cell.imageView.image = UIImage(systemName: "circle.inset.filled")
            cell.imageView.tintColor = .white
            
            
        } else {
            cell.mainView.backgroundColor = .white
            cell.gender.textColor = .lightGray
            cell.mainView.borderColor = .lightGray
            cell.mainView.borderWidth = 1
            cell.imageView.image = UIImage(systemName: "circle")
            cell.imageView.tintColor = .gray
        }
        return cell
    }
}
