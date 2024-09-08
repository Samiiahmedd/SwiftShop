//
//  SearchCategoriesViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 05/09/2024.
//

import UIKit

class SearchCategoriesViewController: UIViewController {
    
    //MARK: - IBoutlet
    
    @IBOutlet var searchCategoriesCollectionView: UICollectionView!
    
    @IBOutlet weak var SearchView: UIView!
    //MARK: - Variables
    
    let viewModel = SearchCategoriesViewModel()
    
    //MARK: - ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - SETUP VIEW

private extension SearchCategoriesViewController {
    func setupView() {
        configerCollectionViews()
        registerCells()
    }
    
    func configerCollectionViews() {
        searchCategoriesCollectionView.delegate = self
        searchCategoriesCollectionView.dataSource = self
    }
    
    func registerCells() {
        searchCategoriesCollectionView.register(UINib(nibName: SearchCategoriesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SearchCategoriesCollectionViewCell.identifier)
    }
}

//MARK: - EXTENTIONS

extension SearchCategoriesViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchCategoriesCollectionView.dequeueReusableCell(withReuseIdentifier: SearchCategoriesCollectionViewCell.identifier, for: indexPath) as! SearchCategoriesCollectionViewCell
        let categorySection = viewModel.categories[indexPath.row]
        cell.Setup(categories: categorySection)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width) - 40 , height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = viewModel.categories[indexPath.row]
        switch selectedCategory.categoryTitle {
        case "Clothes":
            let clothesCategoryVC = ClothesCategoryViewController(nibName: "ClothesCategoryViewController", bundle: nil)
            clothesCategoryVC.title = "Clothes"
            navigationController?.pushViewController(clothesCategoryVC, animated: true)
            
        case "Bags":
            let bagsCategoryVC = BagsCategoryViewController(nibName: "BagsCategoryViewController", bundle: nil)
            bagsCategoryVC.title = "Bags"
            navigationController?.pushViewController(bagsCategoryVC, animated: true)
            
        case "New Arrivals":
            let newArrivalVC = NewArrivalViewController(nibName: "NewArrivalViewController", bundle: nil)
            newArrivalVC.title = "New Arrivals"
            navigationController?.pushViewController(newArrivalVC, animated: true)
            
        case "Shoses":
            let shosesVC = ShosesViewController(nibName: "ShosesViewController", bundle: nil)
            shosesVC.title = "Shoses"
            navigationController?.pushViewController(shosesVC, animated: true)   
            
        case "Electronics":
            let elecronicVC = ElectronicsViewController(nibName: "ElectronicsViewController", bundle: nil)
            elecronicVC.title = "Electronics"
            navigationController?.pushViewController(elecronicVC, animated: true)
        default:
            break
        }
    }
}
