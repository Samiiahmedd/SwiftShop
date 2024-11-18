//
//  CartViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 08/09/2024.
//

import UIKit
import Combine

class CartViewController: UIViewController {
    
    //MARK: - VARIABLES
    
    private var viewModel: CartViewModel
    private var cancellable = Set<AnyCancellable>()
    var coordinator: HomeCoordinatorProtocol?
    //MARK: - IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet weak var cartProductsTableView: SelfSizedTableView!
    @IBOutlet weak var noDataImage: UIImageView!
    @IBOutlet weak var subtotalPrice: UILabel!
    @IBOutlet weak var shippingPrice: UILabel!
    @IBOutlet weak var bagTotalPrice: UILabel!
    @IBOutlet weak var bagTotalItems: UILabel!
    @IBOutlet weak var checkoutButton: UIButton!
    
    //MARK: - INITIALIZER
    
    init(viewModel: CartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getCartProducts()
        bindViewModel()
        
        viewModel.$totalPrice
            .sink { [weak self] price in
                let boldTitle = NSAttributedString(
                    string: "Process to payment \(price)",
                    attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .bold)]
                )
                self?.checkoutButton.setAttributedTitle(boldTitle, for: .normal)
            }
            .store(in: &cancellable)
              
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationItem.hidesBackButton = true
    }
    
    //MARK: - FUNCTIONS
    
    private func getCartProducts() {
        viewModel.getCart()
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
        let cart = viewModel.cartItem[indexPath.row]
        cell.Setup(cartItem: cart)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cartItem.count
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, complete in
            let itemToDelete = self.viewModel.cartItem[indexPath.row]
            self.viewModel.cartItem.remove(at: indexPath.row)
            self.viewModel.deleteCartItem(productId: itemToDelete.product.id)
            self.cartProductsTableView.deleteRows(at: [indexPath], with: .automatic)
            complete(true)
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        deleteAction.backgroundColor = .black
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
        
}
// MARK: - VIEW MODEL

private extension CartViewController {
    func bindViewModel() {
        bindIsLoading()
        bindErrorState()
        bindSetupViewModel()
    }
    
    func bindIsLoading() {
        viewModel.isLoading.sink { [weak self] isLoading in
            guard let self else { return }
            if isLoading {
                self.showLoader()
            } else {
                self.hideLoader()
            }
        }.store(in: &cancellable)
    }
    
    func bindErrorState() {
        viewModel.errorMessage.sink { [weak self] error in
            guard let self else { return }
            AlertViewController.showAlert(on: self, image:UIImage(systemName: "xmark.circle.fill")!, title: "Error", message: error, buttonTitle: "OK") {
            }
        }.store(in: &cancellable)
    }
    
    func bindSetupViewModel() {
        viewModel.inCartData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] products in
                self?.viewModel.cartItem = products.cart_items
                self?.cartProductsTableView.reloadData()
            }
            .store(in: &cancellable)
    }
}

