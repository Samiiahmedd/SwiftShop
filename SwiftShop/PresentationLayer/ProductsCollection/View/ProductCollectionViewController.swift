//
//  ProductCollectionViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 06/09/2024.
//

import UIKit

class ProductCollectionViewController: UIViewController {

    //MARK: - IBOUTLETS
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nanBar: CustomNavBar!
    @IBOutlet var productsCollectionView: UICollectionView!

    //MARK: - VARIABLES
    
    var labelTitle: String?
    var viewModel = ProductCollectionViewModel()
    var product: [PopularModel] = []

    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = labelTitle
        setupView()
        fetchAllProducts()
    }
    /// ViewAll
    private func fetchAllProducts() {
            viewModel.getAllProducts { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self?.product = data
                        self?.productsCollectionView.reloadData()
                    case .failure(let error):
                        print("Failed to fetch products: \(error.localizedDescription)")
                    }
                }
            }
        }
}


// MARK: - SETUP VIEW

private extension ProductCollectionViewController {
    func setupView() {
        configureNavBar()
        configerCollectionViews()
        registerCells()
    }
    
    func configureNavBar() {
        
        nanBar.setupFirstLeadingButton(
            with: "",
            and: UIImage(named: "back")!) {
                self.navigationController?.popViewController(animated: true)
            }
        nanBar.firstTralingButton.isHidden = true
        nanBar.lastFirstTralingButton.isHidden = true
    }
    
    func configerCollectionViews() {
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        
    }
    
    func registerCells() {
        productsCollectionView.register(UINib(nibName: HomeProductsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomeProductsCollectionViewCell.identifier)

    }
}

// MARK: - EXtentions

extension ProductCollectionViewController:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let selectedProduct = product[indexPath.item]
//        let productDetailsVC = ProductDetailsViewController(id: selectedProduct.id)
//        self.navigationController?.pushViewController(productDetailsVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeProductsCollectionViewCell.identifier, for: indexPath) as! HomeProductsCollectionViewCell
//        cell.Setup(newArrival: product[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 2) - 24, height: 260)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
