//
//  BagsCategoryViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 06/09/2024.
//

import UIKit

class BagsCategoryViewController: UIViewController {
    
    //MARK: - IBOUTLET
    
    @IBOutlet var bagsCollectionView: UICollectionView!
    
    //MARK: - VARIABLES
    
    var viewModel = BagsCategoryViewModel()
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - SETUP VIEW

private extension BagsCategoryViewController {
    func setupView() {
        configerCollectionViews()
        registerCells()
    }
    
    func configerCollectionViews() {
        bagsCollectionView.delegate = self
        bagsCollectionView.dataSource = self
        
    }
    
    func registerCells() {
        bagsCollectionView.register(UINib(nibName: NewArriivalCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: NewArriivalCollectionViewCell.identifier)

    }
}

// MARK: - EXtentions

extension BagsCategoryViewController:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.newArrivals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewArriivalCollectionViewCell.identifier, for: indexPath) as! NewArriivalCollectionViewCell
        let newArrival = viewModel.newArrivals[indexPath.row]
        cell.Setup(newArrival: newArrival)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width/2) - 40 , height: 210)
    }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 20
        }
    
}
