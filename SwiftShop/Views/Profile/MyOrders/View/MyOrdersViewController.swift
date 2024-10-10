//
//  MyOrdersViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 10/10/2024.
//

import UIKit

class MyOrdersViewController: UIViewController {
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet weak var myOrdersLabel: UILabel!
    @IBOutlet weak var ongoingButton: UIButton!
    @IBOutlet weak var completedButton: UIButton!
    @IBOutlet weak var myOrdersTableView: UITableView!
    
    //MARK: - VARIABLES
    
    let viewModel = MyOrdersViewModel()
    var is_Selected = true
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - @IBACTIONS
    
    @IBAction func ongoingButtonAction(_ sender: Any) {
        is_Selected = true
        configureButtons()
    }
    @IBAction func completedButtonAction(_ sender: Any) {
        is_Selected = false
        configureButtons()
    }
    
}

//MARK: - SETUP VIEW

extension MyOrdersViewController {
    
    func setupView(){
        configureNavBar()
        configureButtons()
        configureTableView()
        registerCell()
    }
    
    func configureNavBar() {
        navBar.setupFirstLeadingButton(with: "", and: UIImage(named: "back")!) {
            self.navigationController?.popViewController(animated: true)
        }
        navBar.firstTralingButton.isHidden = true
    }
    
    func configureButtons() {
        if is_Selected {
            ongoingButton.backgroundColor = .black
            ongoingButton.tintColor = .white
            ongoingButton.layer.cornerRadius = 10
            ongoingButton.layer.borderColor = UIColor.systemGray3.cgColor
            ongoingButton.layer.borderWidth = 1
            
            completedButton.backgroundColor = .white
            completedButton.tintColor = .gray
            completedButton.layer.cornerRadius = 10
            completedButton.layer.borderColor = UIColor.systemGray3.cgColor
            completedButton.layer.borderWidth = 1
        } else {
            ongoingButton.backgroundColor = .white
            ongoingButton.tintColor = .gray
            ongoingButton.layer.cornerRadius = 10
            ongoingButton.layer.borderColor = UIColor.systemGray3.cgColor
            ongoingButton.layer.borderWidth = 1
            
            completedButton.backgroundColor = .black
            completedButton.tintColor = .white
            completedButton.layer.cornerRadius = 10
            completedButton.layer.borderColor = UIColor.systemGray3.cgColor
            completedButton.layer.borderWidth = 1
        }
    }
    
    func configureTableView() {
        myOrdersTableView.dataSource = self
        myOrdersTableView.delegate = self
    }
    
    func registerCell() {
        myOrdersTableView.register(UINib(nibName: "MyOrdersTableViewCell", bundle: nil), forCellReuseIdentifier: "MyOrdersTableViewCell")
    }
}

///TableView

extension MyOrdersViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.MyOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myOrdersTableView.dequeueReusableCell(withIdentifier: MyOrdersTableViewCell.identifier, for: indexPath) as! MyOrdersTableViewCell
        let MyOrder = viewModel.MyOrders[indexPath.row]
        cell.setup(Myorders: MyOrder)
        return cell
    }
}
