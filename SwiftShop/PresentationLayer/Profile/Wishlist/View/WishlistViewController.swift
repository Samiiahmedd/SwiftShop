//
//  WishlistViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 02/10/2024.
//

import UIKit
import Combine

class WishlistViewController: UIViewController {
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet weak var searchBar: CustomSearchBar!
    @IBOutlet weak var wishlistTableView: UITableView!
    
    //MARK: - VARIABLES
    
    var viewModel = WishlistViewModel()
    private var cancellables = Set<AnyCancellable>()

    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
    @MainActor
    private func bindViewModel() {
        viewModel.$favouriteProduct
            .sink { [weak self] _ in
                self?.wishlistTableView.reloadData()
            }
            .store(in: &cancellables)
    }

}

// MARK: - SETUP VIEW

private extension WishlistViewController {
    
    func setupView() {
        configureNavBar()
        configureTableViews()
        registerCells()
        configureSearchBar()
    }
    
    func configureNavBar() {
        navBar.setupFirstLeadingButton(with: "", and: UIImage(named: "back")!) {
            self.navigationController?.popViewController(animated: true)
        }
        navBar.firstTralingButton.isHidden = true
        navBar.lastFirstTralingButton.isHidden = true

    }
    
    func configureTableViews() {
        wishlistTableView.delegate = self
        wishlistTableView.dataSource = self
    }
    
    func registerCells() {
        wishlistTableView.register(UINib(nibName: "WishlistTableViewCell", bundle: nil), forCellReuseIdentifier: "WishlistTableViewCell")
    }
    func configureSearchBar() {
        searchBar.searchTextField.cornerRadius = 24
        searchBar.searchTextField.borderColor = .systemGray3
        searchBar.searchTextField.borderWidth = 1
        searchBar.searchTextField.placeholder = "Search..."
        
    }
}

//MARK: - Extentions

extension WishlistViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favouriteProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = wishlistTableView.dequeueReusableCell(withIdentifier: WishlistTableViewCell.identifier, for: indexPath) as! WishlistTableViewCell
        let wishlistItem = viewModel.favouriteProduct[indexPath.row]
        let productModel = ProductDetailsModel(from: wishlistItem )
        cell.Setup(Wishlist: productModel)
        return cell
    }
    
}
