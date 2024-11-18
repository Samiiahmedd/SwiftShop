//
//  NotificationsViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 03/10/2024.
//

import UIKit

class NotificationsViewController: UIViewController {
    
    //MARK: - IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet weak var notificationTableVIew: UITableView!
    
    //MARK: - VARIABLES
    
    var viewModel = NotificationsViewModel()
    var coordinator: HomeCoordinatorProtocol?

    //MARK: - VIEWLIFE CYCLEA
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationItem.hidesBackButton = true
     }
}

// MARK: - SETUP VIEW

private extension NotificationsViewController {
    
    func setupView() {
        configureNavBar()
        configureTableViews()
        registerCells()
    }
    
    func configureNavBar() {
        navBar.setupFirstTralingButton(
            with: "",
            and:UIImage(named: "cart")!)
        { [self] in
            coordinator?.displayCart()
        }
        
        navBar.lastFirstTralingButton.isHidden = true
        
        navBar.setupFirstLeadingButton(
            with: "",
            and: UIImage(named: "back")!) {
                self.navigationController?.popViewController(animated: true)
            }
        navBar.tintColor = .black
        
    }
    
    func configureTableViews() {
        notificationTableVIew.delegate = self
        notificationTableVIew.dataSource = self
    }
    
    func registerCells() {
        notificationTableVIew.register(UINib(nibName: "NotificationsTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationsTableViewCell")
    }
}

//MARK: - EXTENSION

extension NotificationsViewController :  UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notificationTableVIew.dequeueReusableCell(withIdentifier: NotificationsTableViewCell.identifier, for: indexPath) as! NotificationsTableViewCell
        let Notifications = viewModel.Notifications[indexPath.row]
        cell.Setup(Notification: Notifications)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.Notifications.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, complete in
            self.viewModel.Notifications.remove(at: indexPath.row)
            self.notificationTableVIew.deleteRows(at: [indexPath], with: .automatic)
            complete(true)
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        deleteAction.image?.withTintColor(.white)
        deleteAction.backgroundColor = .black
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
}
