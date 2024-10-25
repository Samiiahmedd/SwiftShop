//
//  ShippingViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 04/10/2024.
//

import UIKit

class ShippingViewController: UIViewController {
    
    enum Mode {
        case checkout
        case settings
    }
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet weak var nanBar: CustomNavBar!
    @IBOutlet weak var titsle: UILabel!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var addAddressLabel: UIButton!
    @IBOutlet weak var addressCollectionView: UICollectionView!
    @IBOutlet weak var processToPaymentButton: UIButton!
    
    //MARK: - VARIABLES
    
    var addresses: [Address] = []
    let userDefaultsManager = UserDefaultsManager()
    var mode: Mode = .checkout

    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAddresses()
        setupView()
        processToPaymentButton.isHidden = (mode == .settings)
    }
    
    //MARK: - @IBACTIONS
    
    @IBAction func addAddressAction(_ sender: Any) {
        let addAddVC = ShippingAddressViewController.instantiateFromXIB()!
        addAddVC.delegate = self
        navigationController?.pushViewController(addAddVC, animated: true)
    }
    
    @IBAction func processToPaymentButtonAction(_ sender: Any) {
        if addresses.isEmpty {
            AlertViewController.showAlert(on: self, image: UIImage(systemName: "exclamationmark.shield.fill")!, title: "No Address", message: "Please add an address before proceeding to payment.", buttonTitle: "OK") {
            }
        } else {
            let payment = CardEnterViewController.instantiateFromXIB()!
            navigationController?.pushViewController(payment, animated: true)
        }
    }
}

//MARK: - SETUP

extension ShippingViewController {
    
    func setupView() {
        setupNavBar()
        configureCollectionView()
        registerCells()
    }
    
    func setupNavBar() {
        nanBar.setupFirstLeadingButton(with: "", and: UIImage(named: "back")!) {
            self.navigationController?.popViewController(animated: true)        }
        nanBar.firstTralingButton.isHidden = true
    }
    
    func configureCollectionView() {
        
        addressCollectionView.delegate = self
        addressCollectionView.dataSource = self
    }
    
    func registerCells() {
        addressCollectionView.register(UINib(nibName: "AddressCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddressCell")
    }
    
    private func loadAddresses() {
        addresses = userDefaultsManager.loadAddresses()
        addressCollectionView.reloadData()
    }
    
    private func saveAddresses() {
        userDefaultsManager.saveAddresses(addresses)
    }
    
    
}



extension ShippingViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addresses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddressCell", for: indexPath) as! AddressCollectionViewCell
        let address = addresses[indexPath.item]
        cell.setup(with: address)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-20, height: 120)
        
    }
}

extension ShippingViewController: AddressDelegate {
    func didAddAddress(_ address: Address) {
        addresses.append(address)
        saveAddresses()
        addressCollectionView.reloadData()
    }
}
