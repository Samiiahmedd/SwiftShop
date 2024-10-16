//
//  ShippingViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 04/10/2024.
//

import UIKit

class ShippingViewController: UIViewController {
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet weak var nanBar: CustomNavBar!
    @IBOutlet weak var titsle: UILabel!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var addAddressLabel: UIButton!
    @IBOutlet weak var addressCollectionView: UICollectionView!
    
    //MARK: - VARIABLES
    
    var addresses: [Address] = []
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - @IBACTIONS
    
    @IBAction func addAddressAction(_ sender: Any) {
        let addAddVC = ShippingAddressViewController.instantiateFromXIB()!
        addAddVC.delegate = self
        navigationController?.pushViewController(addAddVC, animated: true)
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
        addressCollectionView.reloadData()
    }
}

