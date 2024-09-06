//
//  ShosesViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 06/09/2024.
//

import UIKit

class ShosesViewController: UIViewController {
    
    //MARK: - IBOUTLETS

    @IBOutlet var shosesCollectionView: UICollectionView!
    
    //MARK: - VARIABLES
    
    var viewModel = ShosesViewModel()
    
    //MARK: - VIEW LIFE CYCLEs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - SETUP VIEW

private extension ShosesViewController {
    func setupView() {
        configerCollectionViews()
        registerCells()
    }
    
    func configerCollectionViews() {
        shosesCollectionView.delegate = self
        shosesCollectionView.dataSource = self
        
    }
    
    func registerCells() {
        shosesCollectionView.register(UINib(nibName: NewArriivalCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: NewArriivalCollectionViewCell.identifier)

    }
}

// MARK: - EXtentions

extension ShosesViewController:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
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
