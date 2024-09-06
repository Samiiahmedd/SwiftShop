//
//  ElectronicsViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 06/09/2024.
//

import UIKit

class ElectronicsViewController: UIViewController {

    //MARK: - IBOUTLETS
    
    @IBOutlet var electronicsCollectionView: UICollectionView!
    
    //MARK: - VARIABLES
    
    var viewModel = ElectronicsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}
// MARK: - SETUP VIEW

private extension ElectronicsViewController {
    func setupView() {
        configerCollectionViews()
        registerCells()
    }
    
    func configerCollectionViews() {
        electronicsCollectionView.delegate = self
        electronicsCollectionView.dataSource = self
        
    }
    
    func registerCells() {
        electronicsCollectionView.register(UINib(nibName: NewArriivalCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: NewArriivalCollectionViewCell.identifier)

    }
}

// MARK: - EXtentions

extension ElectronicsViewController:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
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

