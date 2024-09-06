//
//  NewArrivalViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 06/09/2024.
//

import UIKit

class NewArrivalViewController: UIViewController {
    
    //MARK: - Variables
    
    var viewModel = NewArrivalViewModel()
    
    //MARK: - IBOUTLETs
    
    @IBOutlet var newArrivalCollectionView: UICollectionView!
    
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
 }

// MARK: - SETUP VIEW

private extension NewArrivalViewController {
    func setupView() {
        configerCollectionViews()
        registerCells()
    }
    
    func configerCollectionViews() {
        newArrivalCollectionView.delegate = self
        newArrivalCollectionView.dataSource = self
        
    }
    
    func registerCells() {
        newArrivalCollectionView.register(UINib(nibName: NewArriivalCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: NewArriivalCollectionViewCell.identifier)

    }
}

// MARK: - EXtentions

extension NewArrivalViewController:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
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
