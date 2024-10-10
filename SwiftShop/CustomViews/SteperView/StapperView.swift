//
//  StapperView.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 08/09/2024.
//

import UIKit

// MARK: - StapperDelegate
//
public protocol StapperViewDelegate: AnyObject {
    func stapperView(_ stapper: StapperView, didSet value: Int)
}

open class StapperView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet weak private(set) var counterLabel: UILabel!
    @IBOutlet weak private(set) var plusButton: UIButton!
    @IBOutlet weak private(set) var minusButton: UIButton!
    
    // MARK: - Properties
    //
    var value: Int = 0
    var maximumValue: Int = 100
    var minmumValue: Int = 0 {
        didSet {
            updateLabel(minmumValue)
            value = minmumValue
        }
    }
    
    weak var delegate: (any StapperViewDelegate)?
    var onValueChange: ((Int) -> Void)?
    
    // MARK: - Initialization
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    public func setTintColor(_ color: UIColor) {
        plusButton.setTitleColor(color, for: .normal)
        minusButton.setTitleColor(color, for: .normal)
        counterLabel.textColor = color
    }
}

// MARK: - Setup

private extension StapperView {
    func setupView() {
        loadNib()
        configureCounterLabel()
        configureContainerView()
        configureStepperButtons()
    }
    
    func loadNib() {
        if let loadedViews = Bundle.main.loadNibNamed(String(describing: Self.self), owner: self, options: nil),
           let view = loadedViews.first as? UIView {
            addSubview(view)
            view.frame = bounds
        }
    }
    
    func configureCounterLabel() {
        counterLabel.text = String(minmumValue)
    }
    
    func configureContainerView() {
        backgroundColor = .white
        layer.cornerRadius = 15
    }
    
    func configureStepperButtons() {
        stepperButton(button: plusButton, text: "+", value: 1)
        stepperButton(button: minusButton, text: "-", value: -1)
        
        plusButton.addAction(.init(handler: {_ in self.plusButtonTapped() }), for: .touchUpInside)
        minusButton.addAction(.init(handler: {_ in self.minusButtonTapped() }), for: .touchUpInside)
    }
    
    func stepperButton(button: UIButton, text: String, value: Int) {
        button.setTitle(text, for: .normal)
        button.tag = value
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = .clear
    }
}

// MARK: - ACTIONS

private extension StapperView {
    func plusButtonTapped() {
        if value <= maximumValue {
            value += 1
            updateValue(value)
        }
    }
    
    func minusButtonTapped() {
        if value > minmumValue {
            value -= 1
            updateValue(value)
        }
    }
    
     func updateValue(_ value: Int) {
        updateLabel(value)
        delegate?.stapperView(self, didSet: value)
        onValueChange?(value) // Notify via closure
    }
    
    func updateLabel(_ value: Int) {
        counterLabel.text = String(value)
    }
}

