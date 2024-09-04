//
//  HomeVC.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 30/08/2024.
//

import UIKit

class HomeVC: UIViewController{
    
    // MARK: - Variables
    
    private let viewModel = HomeViewModel()
    
    //MARK: - IBOutlet
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var bannerCollectionView: UICollectionView!
    @IBOutlet var newArriivalCollectionView: UICollectionView!
    @IBOutlet var popularsColllectionView: UICollectionView!
    
    //MARK: - viewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        newArriivalCollectionView.delegate = self
        newArriivalCollectionView.dataSource = self
        popularsColllectionView.delegate = self
        popularsColllectionView.dataSource = self
    }
    
    //MARK: - Functions
    
    private func registerCells() {
        
        bannerCollectionView.register(UINib(nibName: BannerCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
        
        newArriivalCollectionView.register(UINib(nibName: NewArriivalCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: NewArriivalCollectionViewCell.identifier)
        
        popularsColllectionView.register(UINib(nibName: PopularsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PopularsCollectionViewCell.identifier)
    }
}

//MARK: - Extentions

extension HomeVC :  UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case bannerCollectionView:
            return viewModel.banners.count
            
        case newArriivalCollectionView :
            return viewModel.newArrivals.count
            
        case popularsColllectionView :
            return viewModel.popular.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case bannerCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as! BannerCollectionViewCell
            let banner = viewModel.banners[indexPath.row]
            cell.Setup(banner: banner)
            return cell
            
        case newArriivalCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewArriivalCollectionViewCell.identifier, for: indexPath) as! NewArriivalCollectionViewCell
            let newArrival = viewModel.newArrivals[indexPath.row]
            cell.Setup(newArrival: newArrival)
            return cell
            
        case popularsColllectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularsCollectionViewCell.identifier, for: indexPath) as! PopularsCollectionViewCell
            let popularProduct = viewModel.popular[indexPath.row]
            cell.Setup(Populars: popularProduct)
            return cell
            
        default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
            
        case bannerCollectionView:
            return CGSize(width: collectionView.frame.size.width-60, height: collectionView.frame.size.height)
            
        case newArriivalCollectionView:
            return CGSize(width: collectionView.frame.size.width/2, height: collectionView.frame.size.height)
            
        case popularsColllectionView:
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)

        default:
            return CGSize(width: 100, height: 100)
        }
    }
}







