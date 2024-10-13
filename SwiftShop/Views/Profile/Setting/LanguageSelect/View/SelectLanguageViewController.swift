//
//  SelectLanguageViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 09/10/2024.
//

import UIKit

class SelectLanguageViewController: UIViewController {
    
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet weak var searchBar: CustomSearchBar!
    @IBOutlet weak var selectLanguageLabel: UILabel!
    @IBOutlet weak var languageTableView: UITableView!
    
    //MARK: - VARIABLES
    
    var viewModel = SelectLanguageViewModel()
    var selectedLanguageIndex: IndexPath?

    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

//SETUP VIEW

extension SelectLanguageViewController {
    
    func setupView() {
        configureNavBar()
        configureSearchBar()
        configureTableView()
        registerCells()
    }
    
    func configureNavBar(){
        
        navBar.setupFirstLeadingButton(with: "", and: UIImage(named: "back")!) {
            self.navigationController?.popViewController(animated: true)
        }
        navBar.firstTralingButton.isHidden = true
    }
    
    func configureSearchBar() {
        searchBar.searchTextField.cornerRadius = 24
        searchBar.searchTextField.borderColor = .systemGray3
        searchBar.searchTextField.borderWidth = 1
        searchBar.searchTextField.placeholder = "Search language..."
        
    }
    
    func configureTableView() {
        languageTableView.dataSource = self
        languageTableView.delegate = self
        
    }
    func registerCells() {
        languageTableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
    }
}

///Table View
extension SelectLanguageViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = languageTableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
            let language = viewModel.languages[indexPath.row]
            cell.Setup(ProfileCell: language)
            
            if selectedLanguageIndex == indexPath {
                cell.mainView.backgroundColor = .black
                cell.title.textColor = .white
                cell.mainView.borderColor = .black
                cell.mainView.borderWidth = 1
                cell.arrow.image = UIImage(systemName: "circle.inset.filled")
                cell.arrow.tintColor = .white
            } else {
                cell.mainView.backgroundColor = .white
                cell.title.textColor = .black
                cell.mainView.borderColor = .white
                cell.arrow.image = UIImage(systemName: "circle")
                cell.arrow.tintColor = .gray
            }
            return cell
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.cornerRadius = 16
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.1
        cell.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.layer.shadowRadius = 12
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: 16).cgPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          selectedLanguageIndex = indexPath
          tableView.reloadData()
      }
}

