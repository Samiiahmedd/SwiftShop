//
//  CartViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 08/09/2024.
//

import UIKit

class CartViewController: UIViewController {
    
    //MARK: - VARIABLES
    
    var viewModel = CartViewModel()
    var carts: [CartItem] = []
    
    //MARK: - IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet weak var cartProductsTableView: SelfSizedTableView!
    @IBOutlet weak var noDataImage: UIImageView!
    @IBOutlet weak var subtotalPrice: UILabel!
    @IBOutlet weak var shippingPrice: UILabel!
    @IBOutlet weak var bagTotalPrice: UILabel!
    @IBOutlet weak var bagTotalItems: UILabel!
    @IBOutlet weak var checkoutButton: UIButton!
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadCartData()
    }
    
    func loadCartData() {
        viewModel.fetchCartFromAPI { result in
             switch result {
             case .success(let cartResponses):
                 self.carts = cartResponses
                 DispatchQueue.main.async {
                     self.cartProductsTableView.reloadData()
                 }
             case .failure(let error):
                 print("Error fetching cart data: \(error.localizedDescription)")
             }
         }
     }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationItem.hidesBackButton = true
    }
    
    //MARK: - IBACTIONS
    
    @IBAction func chexkoutButtonAction(_ sender: Any) {
        let checkout = ShippingViewController(nibName: "ShippingViewController", bundle: nil)
        checkout.mode = .checkout
        self.navigationController?.pushViewController(checkout, animated: true)
    }
}

// MARK: - SETUP VIEW

private extension CartViewController {
    
    func setupView() {
        configureNavBar()
        configureTableViews()
        registerCells()
    }
    
    func configureNavBar() {
        navBar.setupFirstTralingButton(
            with: "",
            and:UIImage(systemName: "magnifyingglass")!)         {
            let filter = FilterViewController(nibName: "FilterViewController", bundle: nil)
            self.navigationController?.pushViewController(filter, animated: true)
            self.navigationItem.hidesBackButton = true
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
        cartProductsTableView.delegate = self
        cartProductsTableView.dataSource = self
    }
    
    func registerCells() {
        cartProductsTableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")
        
    }
    
    
}

//MARK: - EXTENSION

extension CartViewController :  UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartProductsTableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as! CartTableViewCell
        let cart = carts[indexPath.row]
        cell.Setup(cartItem: cart)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carts.count
    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, complete in
//            self.viewModel.removeFromCart(at: indexPath.row) // Updated to use ViewModel's remove method
//            self.cartProductsTableView.deleteRows(at: [indexPath], with: .automatic)
//            self.updateBagItems() // Update bag total items count
//            complete(true)
//        }
//        deleteAction.image = UIImage(systemName: "trash.fill")
//        deleteAction.backgroundColor = .black
//        
//        return UISwipeActionsConfiguration(actions: [deleteAction])
//    }
    
    
}


