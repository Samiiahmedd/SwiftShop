//
//  SelectedCategoryViewController.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 04/11/2024.
//

import UIKit
import Combine

class SelectedCategoryViewController: BaseViewController {
    
    //MARK: - IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectedCategoryProductsCollectionView: UICollectionView!
    
    //MARK: - VARIABLES
    var labelTitle: String?
    private let categoryId: Int
    private var viewModel: SelectedCategoryViewModel
    private var cancellable = Set<AnyCancellable>()
    
    //MARK: - INITIALIZER
    
    init(viewModel: SelectedCategoryViewModel, categoryId: Int) {
        self.viewModel = viewModel
        self.categoryId = categoryId
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
        viewModel.getCategory()
        
    }
}

//MARK: - SETUP VIEW

extension SelectedCategoryViewController {
    func setupView() {
        configureNavBar()
        configureCollectionView()
        registerCells()
    }
    
    func configureNavBar() {
        navBar.setupFirstLeadingButton(with: "", and: UIImage(named: "back")!) {
            self.navigationController?.popViewController(animated: true)
        }
        navBar.firstTralingButton.isHidden = true
        navBar.lastFirstTralingButton.isHidden = true
    }
    
    func configureCollectionView() {
        selectedCategoryProductsCollectionView.dataSource = self
        selectedCategoryProductsCollectionView.delegate = self
    }
    
    func registerCells() {
        selectedCategoryProductsCollectionView.register(UINib(nibName: HomeProductsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomeProductsCollectionViewCell.identifier)    }
}

extension SelectedCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.productDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeProductsCollectionViewCell.identifier, for: indexPath) as! HomeProductsCollectionViewCell
        let product = viewModel.productDataSource[indexPath.row]
        cell.Setup(product: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 2) - 24, height: 260)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedProduct = viewModel.productDataSource[indexPath.item]
        let productId = selectedProduct.id
        viewModel.productCellTriggerd.send(productId)
    }
}

//MARK: - BIND VIEW MODEL

private extension SelectedCategoryViewController {
    func bindViewModel() {
        bindIsLoading()
        bindErrorState()
        bindSetupViewModel()
    }
    
    func bindIsLoading() {
        viewModel.isLoading.sink { [weak self] isLoading in
            guard let self else { return }
            if isLoading {
                startLoading()
            } else {
                stopLoading()
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
        viewModel.category
            .receive(on: DispatchQueue.main)
            .sink { [weak self] category in
                
                self?.viewModel.productDataSource = category.data
                self?.selectedCategoryProductsCollectionView.reloadData()
                
            }
            .store(in: &cancellable)
    }
}




