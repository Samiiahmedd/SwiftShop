//
//  ProductDetailsViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 07/09/2024.
//

import UIKit
class ProductDetailsViewController: UIViewController {
    
    //MARK: - IBOUTLETS
    
    @IBOutlet var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productReviews: UILabel!
    @IBOutlet var addToCartButton: UIButton!
    @IBOutlet var favouriteButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var stepperView: StapperView!
    @IBOutlet var secondView: UIView!
    @IBOutlet weak var productFullDescription: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sizeCollectionView: UICollectionView!
    @IBOutlet weak var colorsCollectionView: UICollectionView!
    
    
    //MARK: VARIABLES
    
    var Size : [SizeModel] = [.init(size: "S"),
                              .init(size: "M"),
                              .init(size: "L"),
                              .init(size: "XL"),
                              .init(size: "XXL")]
    
    var selectedSizeIndex: IndexPath?
    
    
    
    //MARK: - VIEWLIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondView.roundCorners(corners: [.topLeft,.topRight], radius:30 )
        setupView()
        
    }
    
    //MARK: - IBACTIONS
    
    @IBAction func addToCartButton(_ sender: Any) {
    }
    
    @IBAction func favouriteButton(_ sender: Any) {
    }
    
    @IBAction func addToCartFooterButton(_ sender: Any) {
    }
}

// MARK: - SETUP VIEW

private extension ProductDetailsViewController {
    
    func setupView() {
        configerCollectionViews()
        registerCells()
    }
    
    func configerCollectionViews() {
        sizeCollectionView.delegate = self
        sizeCollectionView.dataSource = self
    }
    
    func registerCells() {
        sizeCollectionView.register(UINib(nibName: SizeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: "SizeCollectionViewCell")
    }
}
extension ProductDetailsViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Size.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SizeCollectionViewCell.identifier, for: indexPath) as! SizeCollectionViewCell
        let sizeModel = Size[indexPath.row]
        cell.sizeLabel.text = sizeModel.size
        
        if selectedSizeIndex == indexPath {
            cell.sizeView.backgroundColor = .black
            cell.sizeLabel.textColor = .white
        } else {
            cell.sizeView.backgroundColor = .white
            cell.sizeLabel.textColor = .darkGray
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedSizeIndex = indexPath
        collectionView.reloadData()
    }
}


