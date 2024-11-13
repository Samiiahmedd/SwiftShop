//
//  ProductCollectionViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 06/09/2024.
//

import UIKit
import Combine

class ProductCollectionViewController: UIViewController {

    //MARK: - IBOUTLETS
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nanBar: CustomNavBar!
    @IBOutlet var productsCollectionView: UICollectionView!

    //MARK: - VARIABLES
    
    var labelTitle: String?
    private var viewModel: ProductCollectionViewModel
    private var cancellable = Set<AnyCancellable>()
    var coordinator: HomeCoordinatorProtocol?

    //MARK: - INITIALIZER
    
    init(viewModel: ProductCollectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = labelTitle
        setupView()
        bindViewModel()
        fetchAllProducts()
    }
    
    //MARK: - FUNCTIONS
    
    private func fetchAllProducts() {
        viewModel.getAllProducts()
    }
}


// MARK: - SETUP VIEW

private extension ProductCollectionViewController {
    func setupView() {
        configureNavBar()
        configerCollectionViews()
        registerCells()
    }
    
    func configureNavBar() {
        
        nanBar.setupFirstLeadingButton(
            with: "",
            and: UIImage(named: "back")!) {
                self.navigationController?.popViewController(animated: true)
            }
        nanBar.firstTralingButton.isHidden = true
        nanBar.lastFirstTralingButton.isHidden = true
    }
    
    func configerCollectionViews() {
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        
    }
    
    func registerCells() {
        productsCollectionView.register(UINib(nibName: HomeProductsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomeProductsCollectionViewCell.identifier)

    }
}

// MARK: - EXtentions

extension ProductCollectionViewController:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedProduct = viewModel.productsDataSource[indexPath.item]
        let viewModel = ProductDetailsViewModel(id: selectedProduct.id, coordinator: self.coordinator!)
        let productDetailsVC = ProductDetailsViewController(viewModel: viewModel, productId: selectedProduct.id)
        self.navigationController?.pushViewController(productDetailsVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.productsDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeProductsCollectionViewCell.identifier, for: indexPath) as! HomeProductsCollectionViewCell
        let product = viewModel.productsDataSource[indexPath.row]
        cell.Setup(product: product)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let totalHorizontalPadding = padding * 3
        let availableWidth = collectionView.frame.width - totalHorizontalPadding
        let cellWidth = availableWidth / 2
        return CGSize(width: cellWidth, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}

// MARK: - VIEW MODEL

private extension ProductCollectionViewController {
    func bindViewModel() {
        bindIsLoading()
        bindErrorState()
        bindSetupViewModel()
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
            AlertViewController.showAlert(on: self, image:UIImage(systemName: "xmark.circle.fill")!, title: "Error", message: error, buttonTitle: "OK") {
            }
        }.store(in: &cancellable)
    }
    
    func bindSetupViewModel() {
        viewModel.homeData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] homeData in
                self?.viewModel.productsDataSource = homeData.products
                self?.productsCollectionView.reloadData()
            }
            .store(in: &cancellable)
    }
}
