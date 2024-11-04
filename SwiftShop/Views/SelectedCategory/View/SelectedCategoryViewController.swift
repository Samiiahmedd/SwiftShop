//
//  SelectedCategoryViewController.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 04/11/2024.
//

import UIKit

class SelectedCategoryViewController: UIViewController {
    
    //MARK: - IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectedCategoryProductsCollectionView: UICollectionView!
    
    //MARK: - VARIABLES
    var labelTitle: String?
    var product: [NewArrival] = []
    var viewModel = SelectedCategoryViewModel()
    var category: String = ""

    
    //MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = labelTitle
        setupView()
        Task {
            await fetchProductsForSelectedCategory()
        }
    }
    
    private func fetchProductsForSelectedCategory() async {
        do {
            let productsByCategory = try await viewModel.getProductsByCategory(category)
            product = productsByCategory
            DispatchQueue.main.async {
                self.selectedCategoryProductsCollectionView.reloadData()
            }
        } catch {
            print("Error fetching products: \(error.localizedDescription)")
        }
    }
}

extension SelectedCategoryViewController {
    func setupView() {
        configureNavBar()
        configureCollectionView()
        registerCells()
    }
    
    func configureNavBar() {
        navBar.setupFirstLeadingButton(with: "", and: UIImage(named: "back")!) {
            self.navigationController?.popViewController(animated: true)
        }
        navBar.firstTralingButton.isHidden = true
        
    }
    
    func configureCollectionView() {
        selectedCategoryProductsCollectionView.dataSource = self
        selectedCategoryProductsCollectionView.delegate = self
    }
    
    func registerCells() {
        selectedCategoryProductsCollectionView.register(UINib(nibName: NewArriivalCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: NewArriivalCollectionViewCell.identifier)    }
}

extension SelectedCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewArriivalCollectionViewCell.identifier, for: indexPath) as! NewArriivalCollectionViewCell
        cell.Setup(newArrival: product[indexPath.row])
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedProduct = product[indexPath.item]
        let productDetailsVC = ProductDetailsViewController(id: selectedProduct.id)
        self.navigationController?.pushViewController(productDetailsVC, animated: true)
    }
}
