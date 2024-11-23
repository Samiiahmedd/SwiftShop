//
//  ShippingViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 04/10/2024.
//

import UIKit
import Combine

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
    
    private var viewModel: ShippingAddressViewModel
    private var cancellable = Set<AnyCancellable>()
    var coordinator: HomeCoordinatorProtocol?
    var mode: Mode = .checkout
    
    //MARK: - INITIALIZER
    
    init(viewModel: ShippingAddressViewModel) {
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
        getAddresss()
        bindViewModel()
    }
    
    //MARK: - @IBACTIONS
    
    @IBAction func addAddressAction(_ sender: Any) {
        coordinator?.displayAddAddressScreen()
    }
    
    @IBAction func processToPaymentButtonAction(_ sender: Any) {
        coordinator?.displayPaymentMethods()
    }
    
    //MARK: - FUNCTIONS
    
    private func getAddresss() {
        viewModel.getAddress()
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
            self.navigationController?.popViewController(animated: true)
        }
        nanBar.firstTralingButton.isHidden = true
        nanBar.lastFirstTralingButton.isHidden = true
    }
    
    func configureCollectionView() {
        addressCollectionView.delegate = self
        addressCollectionView.dataSource = self
    }
    
    func registerCells() {
        addressCollectionView.register(UINib(nibName: AddressCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: AddressCollectionViewCell.identifier)
    }
}

extension ShippingViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.address.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddressCollectionViewCell.identifier, for: indexPath) as! AddressCollectionViewCell
        let address = viewModel.address[indexPath.item]
        cell.setup(address: address)
        
        if address == viewModel.getSelectedAddress() {
            cell.setSelectedState(true)
        } else {
            cell.setSelectedState(false)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedAddress = viewModel.address[indexPath.item]
        viewModel.selectAddress(selectedAddress)
        addressCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-20, height: 120)
        
    }
}

// MARK: - VIEW MODEL

private extension ShippingViewController {
    func bindViewModel() {
        bindIsLoading()
        bindErrorState()
        bindReloadData()
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
    
    func bindReloadData() {
        viewModel.addressData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] address in
                self?.viewModel.address = address.data
                self?.addressCollectionView.reloadData()
            }
            .store(in: &cancellable)
    }
}
