//
//  CartViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 08/09/2024.
//

import UIKit

class CartViewController: UIViewController {
    
    var viewModel = CartViewModel()
    @IBOutlet var cartProductsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        
    }
}

// MARK: - SETUP VIEW

private extension CartViewController {
    
    func setupView() {
        configerCollectionViews()
        registerCells()
        
    }
    
    func configerCollectionViews() {
        cartProductsCollectionView.delegate = self
        cartProductsCollectionView.dataSource = self
    }
    
    func registerCells() {
        cartProductsCollectionView.register(UINib(nibName: CartCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CartCollectionViewCell.identifier)
        
    }
}

//MARK: - Extentions

extension CartViewController :  UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.CartItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CartCollectionViewCell.identifier, for: indexPath) as! CartCollectionViewCell
            let cartt = viewModel.CartItems[indexPath.row]
        cell.Setup(cart: cartt)
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: (collectionView.frame.width) - 40 , height: 240)

        }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.CartItems.count
    }

    
}


