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
    
    var colors: [UIColor] = [.red, .black, .lightGray, .green, .orange]
    
    var selectedColorIndex: Int?
    
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
        colorsCollectionView.delegate = self
        colorsCollectionView.dataSource = self
    }
    
    func registerCells() {
        sizeCollectionView.register(UINib(nibName: SizeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: "SizeCollectionViewCell")
        colorsCollectionView.register(UINib(nibName: ColorCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: "ColorCollectionViewCell")
    }
}
extension ProductDetailsViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case sizeCollectionView:
            return Size.count
        case colorsCollectionView:
            return colors.count
        default:
            return 0
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case sizeCollectionView:
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
            
        case colorsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCollectionViewCell.identifier, for: indexPath) as! ColorCollectionViewCell
            let color = colors[indexPath.row]
            let isSelected = indexPath.row == selectedColorIndex
            cell.configure(with: color, isSelected: isSelected)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case sizeCollectionView :
            return CGSize(width: 50, height: 50)
        case colorsCollectionView :
            return CGSize(width: 35, height: 35)
            
        default:
            return CGSize(width: 100, height: 100)
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case  sizeCollectionView:
            selectedSizeIndex = indexPath
            sizeCollectionView.reloadData()
        case colorsCollectionView :
            selectedColorIndex = indexPath.row
            colorsCollectionView.reloadData()
        default:
            return
        }
    }
}


