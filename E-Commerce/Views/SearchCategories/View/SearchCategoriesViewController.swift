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
        default:
            break
        }
    }
}
