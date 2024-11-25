//
//  WishlistViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 02/10/2024.
//

import UIKit
import Combine

class WishlistViewController: BaseViewController {
    
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet weak var searchBar: CustomSearchBar!
    @IBOutlet weak var wishlistTableView: UITableView!
    
    //MARK: - VARIABLES
    
    private var viewModel: WishlistViewModel
    private var cancellable = Set<AnyCancellable>()
    var coordinator: HomeCoordinatorProtocol?
    
    //MARK: - INITIALIZER
    
    init(viewModel: WishlistViewModel) {
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
        viewModel.getFavourites()
        bindViewModel()
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

//MARK: - VIEW MODEL

extension WishlistViewController {
    func bindViewModel() {
        bindIsLoading()
        bindErrorState()
        bindSetupViewModel()
    }
    
    func bindIsLoading() {
        viewModel.isLoading.sink { [weak self] isLoading in
            guard let self else { return }
            if isLoading {
                startLoading()
            } else {
                stopLoading()
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
        viewModel.inFavouritesData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] product in
                guard let self = self else { return }
                self.viewModel.favouritesItem = product.data
                print(product)
                self.wishlistTableView.reloadData()
            }
            .store(in: &cancellable)
    }

}

//MARK: - Extentions

extension WishlistViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favouritesItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = wishlistTableView.dequeueReusableCell(withIdentifier: WishlistTableViewCell.identifier, for: indexPath) as! WishlistTableViewCell
        let wishlistItem = viewModel.favouritesItem[indexPath.row]
        cell.Setup(Wishlist: wishlistItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, complete in
            let itemToDelete = self.viewModel.favouritesItem[indexPath.row]
            self.viewModel.favouritesItem.remove(at: indexPath.row)
            self.viewModel.deleteProductFromFavourites(productId: itemToDelete.product.id)
            self.wishlistTableView.deleteRows(at: [indexPath], with: .automatic)
            complete(true)
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        deleteAction.backgroundColor = .black
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
