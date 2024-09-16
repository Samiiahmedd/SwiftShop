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
    
    //MARK: - VIEWLIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondView.roundCorners(corners: [.topLeft,.topRight], radius:30 )
        
        
    }
    
    //MARK: - IBACTIONS
    
    @IBAction func addToCartButton(_ sender: Any) {
    }
    
    @IBAction func favouriteButton(_ sender: Any) {
    }
    
    @IBAction func addToCartFooterButton(_ sender: Any) {
    }
}

