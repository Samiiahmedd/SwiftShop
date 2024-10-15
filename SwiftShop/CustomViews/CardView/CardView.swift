//
//  CardViewController.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 14/10/2024.
//

import UIKit

class CardView: UIView {
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var cardNumber: UILabel!
    @IBOutlet weak var cardHolderNameLabel: UILabel!
    @IBOutlet weak var cardHolderName: UILabel!
    @IBOutlet weak var validThruLabel: UILabel!
    @IBOutlet weak var validThrouDate: UILabel!
    
    //MARK: - VARIABLES
    

    
    // MARK: - Initialization
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
}

extension CardView{
    func setupView() {
        loadNib()
    }
    func loadNib() {
        if let loadedViews = Bundle.main.loadNibNamed(String(describing: Self.self), owner: self, options: nil),
           let view = loadedViews.first as? UIView {
            addSubview(view)
            view.frame = bounds
        }
    }
}


