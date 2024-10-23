//
//  CardEnterViewController.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 15/10/2024.
//

import UIKit

class CardEnterViewController: UIViewController {
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet weak var cardView: CardView!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var cardHolderName: UITextField!
    @IBOutlet weak var expierdDateTextField: UITextField!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    //MARK: - VARIABLES
    
    enum CardType {
        case visa
        case masterCard
        case paybal
        case meza
        case unknown
        
        static func getCardType(from number: String) -> CardType {
            if number.hasPrefix("4") {
                return .visa
            } else if number.hasPrefix("5") {
                return .masterCard
            } else if number.hasPrefix("3") {
                return .paybal
            }
            else if number.hasPrefix("6") {
                return .meza
            }
            return .unknown
        }
    }
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupView()
        cardNumberTextField.addTarget(self, action: #selector(cardNumberDidChange(_:)), for: .editingChanged)
        
        cardHolderName.addTarget(self, action: #selector(cardHolderNameDidChange (_:)), for: .editingChanged)
        
        expierdDateTextField.addTarget(self, action: #selector(validThruDateDidChange(_:)), for: .editingChanged)
        configureKeyboardHandling()
    }
    deinit {
        removeKeyboardHandling()
    }
    
    @objc func cardNumberDidChange(_ textField: UITextField) {
        guard let cardNumber = textField.text else { return }
        cardView.cardNumber.text = cardNumber
        
        let cardType = CardType.getCardType(from: cardNumber)
        updateCardView(for: cardType)
    }
    
    @objc func cardHolderNameDidChange(_ textField: UITextField) {
        cardView.cardHolderName.text = textField.text
    }
    
    @objc func validThruDateDidChange(_ textField: UITextField) {
        cardView.validThrouDate.text = textField.text
    }
    
    
    
    //MARK: - @IBACTIONS
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func confirmButtonAction(_ sender: Any) {
        
    }
    
}

//MARK: - SETUP VIEW

extension CardEnterViewController {
    func setupView() {
        configureNavBar()
        configureTextFields()
        handelEndEditing()
    }
    
    func configureNavBar() {
        navBar.setupFirstLeadingButton(with: "", and: UIImage(named: "back")!) {
            self.navigationController?.popViewController(animated: true)
        }
        navBar.firstTralingButton.isHidden = true
    }
    
    func configureTextFields() {
        let textFields: [UITextField] = [cardNumberTextField, cardHolderName,expierdDateTextField,cvvTextField ]
        textFields.forEach { $0.delegate = self }
        
        addPaddingToTextField(cardNumberTextField, padding: 10)
        addPaddingToTextField(expierdDateTextField, padding: 10)
        addPaddingToTextField(cvvTextField, padding: 10)
        addPaddingToTextField(cardHolderName, padding: 10)
    }
    
    func updateCardView(for cardType: CardType) {
        switch cardType {
        case .visa:
            cardView.cardImageView.image = UIImage(named: "gradiennt")
            cardView.cardName.text = "VISA"
        case .masterCard:
            cardView.cardImageView.image = UIImage(named: "gradient1")
            cardView.cardName.text = "MASTER CARD"
        case .paybal:
            cardView.cardImageView.image = UIImage(named: "gradient3")
            cardView.cardName.text = "PAYBAL"
        case .unknown:
            cardView.cardImageView.image = UIImage(named: "blue")
            cardView.cardName.text = "Payment Method"
        case .meza:
            cardView.cardImageView.image = UIImage(named: "green")
            cardView.cardName.text = "MEEZA"
        }
    }
}

// MARK: - TEXT FIELD DELEGATE

extension CardEnterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case cardNumberTextField:
            cardHolderName.becomeFirstResponder()
        case cardHolderName:
            expierdDateTextField.becomeFirstResponder()
        case expierdDateTextField:
            cvvTextField.becomeFirstResponder()
        default:
            view.endEditing(true)
        }
        return true
    }
}
