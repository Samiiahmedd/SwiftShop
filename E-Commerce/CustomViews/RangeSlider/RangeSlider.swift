//
//  RangeSlider.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 22/09/2024.
//

import UIKit

class RangeSlider: UIView {
    
    //MARK: - IBOUTLETS
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var lowerSlider: UISlider!
    @IBOutlet weak var upperSlider: UISlider!
    @IBOutlet weak var lowerPriceLabel: UILabel!
    @IBOutlet weak var middlePriceLabel: UILabel!
    @IBOutlet weak var upperPriceLabel: UILabel!
    
    //MARK: - VIEWLIFECYCLE
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nibSetup()
    }
    
    //MARK: - IBACTION
    
    @IBAction func lowerSliderChange(_ sender: Any) {
        
    }
    
    @IBAction func upperSliderChange(_ sender: Any) {
    }
    
    //MARK: - Functions
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let nibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return UIView() }
        return nibView
    }
    
    func nibSetup() {
        containerView = loadViewFromNib()
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.translatesAutoresizingMaskIntoConstraints = true
        addSubview(containerView)
    }
    
}

