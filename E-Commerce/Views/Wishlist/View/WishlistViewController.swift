//
//  WishlistViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 02/10/2024.
//

import UIKit

class WishlistViewController: UIViewController {
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet weak var searchBar: CustomSearchBar!
    @IBOutlet weak var wishlistTableView: UITableView!
    
    //MARK: - VARIABLES
    
    private let viewModel = WishlistViewModel()

    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - SETUP VIEW

private extension WishlistViewController {
    
    func setupView() {
        configureNavBar()
        configureTableViews()
        registerCells()
    }
    
    func configureNavBar() {
        navBar.setupFirstLeadingButton(with: "", and: UIImage(named: "back")!) {
            print("ok")
        }
        navBar.firstTralingButton.isHidden = true

    }
    
    func configureTableViews() {
        wishlistTableView.delegate = self
        wishlistTableView.dataSource = self
    }
    
    func registerCells() {
        wishlistTableView.register(UINib(nibName: "WishlistTableViewCell", bundle: nil), forCellReuseIdentifier: "WishlistTableViewCell")
    }
}

//MARK: - Extentions

extension WishlistViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.wishlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = wishlistTableView.dequeueReusableCell(withIdentifier: WishlistTableViewCell.identifier, for: indexPath) as! WishlistTableViewCell
        let wishlistItem = viewModel.wishlist[indexPath.row]
        cell.Setup(Wishlist: wishlistItem)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}