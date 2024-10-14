//
//  AddCardViewController.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 11/10/2024.
//

import UIKit

class AddCardViewController: UIViewController {
    
    //MARK: - IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    
    @IBOutlet weak var paymentTableView: UITableView!
    
    //MARK: - VARIABLES
    
    var viewModel = AddCardViewModel()
    var selectedMethodIndex: IndexPath?
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

//MARK: - SETUP VIEW

extension AddCardViewController {
    
    func setupView() {
        configureNavBar()
        configureTableView()
        registerCell()
        
    }
    
    func configureNavBar() {
        navBar.setupFirstLeadingButton(with: "", and: UIImage(named: "back")!) {
            print("")
        }
        navBar.firstTralingButton.isHidden = true
    }
    
    func configureTableView() {
        paymentTableView.dataSource = self
        paymentTableView.delegate = self
        
    }
    
    func registerCell() {
        paymentTableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
    }
}

///TableView
extension AddCardViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.paymentMethod.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = paymentTableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
        let payment = viewModel.paymentMethod[indexPath.row]
        cell.Setup(ProfileCell: payment)
        
        if selectedMethodIndex == indexPath {
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
        selectedMethodIndex = indexPath
        tableView.reloadData()
    }
}
