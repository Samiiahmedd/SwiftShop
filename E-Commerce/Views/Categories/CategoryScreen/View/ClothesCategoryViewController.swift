//
//  ClothesCategoryViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 06/09/2024.
//

import UIKit

class ClothesCategoryViewController: UIViewController {
    

    //MARK: - IBOUTLETS
    
    @IBOutlet weak var nanBar: CustomNavBar!
    
    @IBOutlet var clothesCollectionView: UICollectionView!

    //MARK: - VARIABLES
    
    var viewModel = ClothesCategoryViewModel()
    
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - SETUP VIEW

private extension ClothesCategoryViewController {
    func setupView() {
        configureNavBar()
        configerCollectionViews()
        registerCells()
    }
    
    func configureNavBar() {
        
        nanBar.setupFirstLeadingButton(
            with: "",
            and: UIImage(named: "back")!) {
                print("Button tapped")
                let search = SearchCategoriesViewController(nibName: "SearchCategoriesViewController", bundle: nil)
                self.navigationController?.pushViewController(search, animated: true)
                self.navigationItem.hidesBackButton = true
            }
        nanBar.firstTralingButton.isHidden = true
    }
    
    func configerCollectionViews() {
        clothesCollectionView.delegate = self
        clothesCollectionView.dataSource = self
        
    }
    
    func registerCells() {
        clothesCollectionView.register(UINib(nibName: NewArriivalCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: NewArriivalCollectionViewCell.identifier)

    }
}

// MARK: - EXtentions

extension ClothesCategoryViewController:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.newArrivals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewArriivalCollectionViewCell.identifier, for: indexPath) as! NewArriivalCollectionViewCell
        let newArrival = viewModel.newArrivals[indexPath.row]
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
