//
//  FAQsViewController.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 14/10/2024.
//

import UIKit

class FAQsViewController: UIViewController {
    
    //MARK: - IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet weak var firstQuestionLabel: UILabel!
    @IBOutlet weak var firstShowButton: UIButton!
    @IBOutlet weak var firstAnswerLabel: UILabel!
    @IBOutlet weak var secondQuestionLabel: UILabel!
    @IBOutlet weak var secondShowButton: UIButton!
    @IBOutlet weak var secondAnswerLabel: UILabel!
    @IBOutlet weak var thirdQuestionLabel: UILabel!
    @IBOutlet weak var thirdShowButton: UIButton!
    @IBOutlet weak var thirdAnswerLabel: UILabel!
    @IBOutlet weak var fourthQuestionLabel: UILabel!
    @IBOutlet weak var fourthShowButton: UIButton!
    @IBOutlet weak var fourthAnswerLabel: UILabel!
    
    //MARK: - VARIABLES
    
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        firstShowButton.addTarget(self, action: #selector(toggleFirstAnswer), for: .touchUpInside)
        secondShowButton.addTarget(self, action: #selector(toggleSecondAnswer), for: .touchUpInside)
        thirdShowButton.addTarget(self, action: #selector(toggleThirdAnswer), for: .touchUpInside)
        fourthShowButton.addTarget(self, action: #selector(toggleFourthAnswer), for: .touchUpInside)
    }
    
    //MARK: - IBACTIONS
    
    @IBAction func showButtonAction(_ sender: Any) {
        
    }
    
    
    // MARK: - TOGGLE METHODS
    
    @objc func toggleFirstAnswer() {
        toggleVisibility(for: firstAnswerLabel, using: firstShowButton)
    }
    
    @objc func toggleSecondAnswer() {
        toggleVisibility(for: secondAnswerLabel, using: secondShowButton)
    }
    
    @objc func toggleThirdAnswer() {
        toggleVisibility(for: thirdAnswerLabel, using: thirdShowButton)
    }
    
    @objc func toggleFourthAnswer() {
        toggleVisibility(for: fourthAnswerLabel, using: fourthShowButton)
    }}


//MARK: - Helper Method to Toggle Visibility

func toggleVisibility(for label: UILabel, using button: UIButton) {
    let isVisible = !label.isHidden
    let arrowTitle = isVisible ? "▼" : "▲"
    button.setTitle(arrowTitle, for: .normal)
    UIView.animate(withDuration: 0.3) {
        label.isHidden = isVisible
    }
}

//MARK: - SETUP VIEW

extension FAQsViewController {
    func setupView() {
        configureNavBar()
        configureButton()
        configureAnswerLabel()
    }
    
    func configureNavBar() {
        navBar.setupFirstLeadingButton(with: "", and: UIImage(named: "back")!) {
            self.navigationController?.popViewController(animated: true)
        }
        navBar.firstTralingButton.isHidden = true
    }
    
    func configureButton() {
        firstShowButton.setTitle("▼", for: .normal)
        secondShowButton.setTitle("▼", for: .normal)
        thirdShowButton.setTitle("▼", for: .normal)
        firstShowButton.setTitle("▼", for: .normal)
    }
    
    func configureAnswerLabel() {
        firstAnswerLabel.isHidden = true
        secondAnswerLabel.isHidden = true
        thirdAnswerLabel.isHidden = true
        fourthAnswerLabel.isHidden = true
    }
    
}
