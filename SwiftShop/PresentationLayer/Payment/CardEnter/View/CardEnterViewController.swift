//
//  CardEnterViewController.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 15/10/2024.
//

import UIKit
import Combine

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
    private var viewModel: CardEnterViewModel
    var coordinator: HomeCoordinatorProtocol?
    private var cancellable = Set<AnyCancellable>()
    
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
    
    //MARK: - INITIALIZER
    
    init(viewModel: CardEnterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupView()
        bindViewModel()
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
        if validateForm() {
            placeOrder()
        }
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
        navBar.lastFirstTralingButton.isHidden = true
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

//MARK: - VALIDATE

extension CardEnterViewController {
    func validateForm() -> Bool {
        let cardNumber = cardNumberTextField.text ?? ""
        let cardHolder = cardHolderName.text ?? ""
        let expirationDate = expierdDateTextField.text ?? ""
        let cvv = cvvTextField.text ?? ""
        
        if !isValidCardNumber(cardNumber) {
            showError(message: "Invalid card number.")
            return false
        }
        
        if cardHolder.isEmpty {
            showError(message: "Cardholder name cannot be empty.")
            return false
        }
        
        if !isValidExpirationDate(expirationDate) {
            showError(message: "Invalid expiration date.")
            return false
        }
        
        if !isValidCVV(cvv) {
            showError(message: "Invalid CVV.")
            return false
        }
        
        return true
    }
    
    // MARK: - VALIDATION METHODS
    
    func isValidCardNumber(_ cardNumber: String) -> Bool {
        return cardNumber.count >= 13 && cardNumber.count <= 19
    }
    
    
    func isValidExpirationDate(_ expirationDate: String) -> Bool {
        // Check expiration date format (MM/YY)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/yy"
        if let date = dateFormatter.date(from: expirationDate), date > Date() {
            return true
        }
        return false
    }
    
    func isValidCVV(_ cvv: String) -> Bool {
        // CVV should be 3 digits
        return cvv.count == 3
    }
    
    func showError(message: String) {
        // Show alert with error message
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}


// MARK: - VIEW MODEL

private extension CardEnterViewController {
    func bindViewModel() {
        bindIsLoading()
        bindErrorState()
    }
    
    func bindIsLoading() {
        viewModel.isLoading.sink { [weak self] isLoading in
            guard let self else { return }
            if isLoading {
                self.showLoader()
            } else {
                self.hideLoader()
            }
        }.store(in: &cancellable)
    }
    
    func bindErrorState() {
        viewModel.errorMessage.sink { [weak self] error in
            guard let self else { return }
            AlertViewController.showAlert(on: self, image:UIImage(systemName: "xmark.circle.fill")!, title: "Login Error", message: error, buttonTitle: "OK") {
            }
        }.store(in: &cancellable)
    }
    
    func placeOrder() {
        viewModel.placeOrder()
    }
}

