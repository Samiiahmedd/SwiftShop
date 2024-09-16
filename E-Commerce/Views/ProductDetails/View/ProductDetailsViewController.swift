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
    @IBOutlet var addToCartButton: UIButton!
    @IBOutlet var favouriteButton: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var secondView: UIView!
    //MARK: - Variables
    
    
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
    
}

