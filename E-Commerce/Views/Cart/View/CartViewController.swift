//
//  CartViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 08/09/2024.
//

import UIKit

class CartViewController: UIViewController {
    
    var viewModel = CartViewModel()
    
    @IBOutlet weak var cartProductsTableView: SelfSizedTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        
    }
}

// MARK: - SETUP VIEW

private extension CartViewController {
    
    func setupView() {
        configureTableViews()
        registerCells()
        
    }
    
    func configureTableViews() {
        cartProductsTableView.delegate = self
        cartProductsTableView.dataSource = self
    }
    
    func registerCells() {
        cartProductsTableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")
        
    }
}

//MARK: - Extentions

extension CartViewController :  UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartProductsTableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as! CartTableViewCell
        let Cartitems = viewModel.CartItems[indexPath.row]
        cell.Setup(Cart: Cartitems)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.CartItems.count
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, complete in
            self.viewModel.CartItems.remove(at: indexPath.row)
            self.cartProductsTableView.deleteRows(at: [indexPath], with: .automatic) //
            complete(true)
        }
        
        // here set your image and background color
        deleteAction.image = UIImage(systemName: "trash.fill")
        deleteAction.image?.withTintColor(.white)
        deleteAction.backgroundColor = .black
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    
}


