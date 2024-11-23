//
//  SearchCategoriesViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 05/09/2024.
//

import UIKit
import Combine

class SearchCategoriesViewController: BaseViewController {
    
    //MARK: - IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet var searchCategoriesCollectionView: UICollectionView!
    @IBOutlet weak var SearchView: UIView!
    
    //MARK: - VARIABLES
    
    private var viewModel: SearchCategoriesViewModel
    private var cancellable = Set<AnyCancellable>()
    var coordinator: HomeCoordinatorProtocol?
    
    //MARK: - INITIALIZER
    
    init(viewModel: SearchCategoriesViewModel) {
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
        viewModel.getAllCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationItem.hidesBackButton = true
    }
}

// MARK: - SETUP VIEW

private extension SearchCategoriesViewController {
    func setupView() {
        configerCollectionViews()
        registerCells()
        configureNavBar()
    }
    
    func configureNavBar() {
        navBar.setupFirstLeadingButton(
            with: "",
            and: UIImage(named: "back")!) {
                self.navigationController?.popViewController(animated: true)
            }
        navBar.lastFirstTralingButton.isHidden = true
        navBar.firstTralingButton.isHidden = true
    }
    
    func configerCollectionViews() {
        searchCategoriesCollectionView.delegate = self
        searchCategoriesCollectionView.dataSource = self
    }
    
    func registerCells() {
        searchCategoriesCollectionView.register(UINib(nibName: SearchCategoriesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SearchCategoriesCollectionViewCell.identifier)
    }
}


// MARK: - VIEW MODEL

private extension SearchCategoriesViewController {
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
        viewModel.categories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] categories in
                self?.viewModel.categoryDataSource = categories.data
                self?.searchCategoriesCollectionView.reloadData()
            }
            .store(in: &cancellable)
    }
}

//MARK: - EXTENTIONS

extension SearchCategoriesViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categoryDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchCategoriesCollectionView.dequeueReusableCell(withReuseIdentifier: SearchCategoriesCollectionViewCell.identifier, for: indexPath) as! SearchCategoriesCollectionViewCell
        let category = viewModel.categoryDataSource[indexPath.row]
        cell.setup(category: category)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let totalHorizontalPadding = padding * 3
        let availableWidth = collectionView.frame.width - totalHorizontalPadding
        let cellWidth = availableWidth / 2
        return CGSize(width: cellWidth, height: cellWidth)
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
    
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let selectedCategorry = viewModel.categoryDataSource[indexPath.item]
            let viewModel = SelectedCategoryViewModel(id: selectedCategorry.id, coordinator: self.coordinator!)
            let selectedCategorryVC = SelectedCategoryViewController(viewModel: viewModel, categoryId: selectedCategorry.id)
            self.navigationController?.pushViewController(selectedCategorryVC, animated: true)
        }
}
