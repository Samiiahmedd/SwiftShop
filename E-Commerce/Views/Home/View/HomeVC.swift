//
//  HomeVC.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 30/08/2024.
//

import UIKit

class HomeVC: UIViewController{
    
    //MARK: - Variables
    
    var banners : [BannerModel] = [
        .init(image: UIImage(named: "Banner")!),
        .init(image: UIImage(named: "Banner")!),
        .init(image: UIImage(named: "Banner")!),
        .init(image: UIImage(named: "Banner")!),
    ]
    
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
        
    }
    
    //MARK: - Functions
    
    private func registerCells() {
        bannerCollectionView.register(UINib(nibName: BannerCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
    }
}

//MARK: - Extentions

extension HomeVC :  UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as! BannerCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case bannerCollectionView:
            
            return CGSize(width: collectionView.frame.size.width-60, height: collectionView.frame.size.height)
            
        default:
            return CGSize(width: 100, height: 100)
        }
    }
}







