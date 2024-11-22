//
//  HomeVC.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 30/08/2024.
//

import UIKit
import Combine
import Kingfisher

class HomeVC: BaseViewController {
    
    //MARK: - IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var homeCategoriesCollectionView: UICollectionView!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var popularTableView: SelfSizedTableView!
    @IBOutlet weak var homeAdsImageView: UIImageView!
    @IBOutlet weak var mainContent: UIScrollView!
    
    // MARK: - VARIABLES
    
    private var viewModel: HomeViewModel
    private var cancellable = Set<AnyCancellable>()
    var coordinator: HomeCoordinatorProtocol?
    
    //MARK: - INITIALIZER
    
    init(viewModel: HomeViewModel) {
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
        fetchHome()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationItem.hidesBackButton = true
    }
    
    
    //MARK: - @IBACTIONS
    
    @IBAction func viewAllNewArrivalsButtonAvtion(_ sender: Any) {
        coordinator?.displayAllProducts()
    }
    
    //    @IBAction func viewAllPopularsButtonAction(_ sender: Any) {
    //        coordinator?.displayAllProducts()
    //    }
    
    //MARK: - FUNCTIONS
    
    private func fetchHome() {
        viewModel.getHomeProducts()
        viewModel.getAllCategories()

    }
}

// MARK: - SETUP VIEW

private extension HomeVC {
    
    func setupView() {
        configerCollectionViews()
        //        configureTableViews()
        registerCells()
        configureNavBar()
    }
    
    func configureNavBar() {
        navBar.setupFirstTralingButton(
            with: "",
            and: UIImage(systemName: "magnifyingglass")!) { [self] in
                coordinator?.displaySearchScreen()
            }
        
        navBar.setupLastFirstTralingButton(with: "", and: UIImage(named: "cart")!) { [self] in
            viewModel.searchButtonActionTriggered.send()
        }
        
        navBar.setupFirstLeadingButton(
            with: "",
            and: UIImage(named: "menu")!) { [self] in
                viewModel.categoriesButtonActionTriggered.send()
            }
        navBar.tintColor = .black
        navBar.containerView.backgroundColor = . systemGray6
}
    
    //        func configureTableViews() {
    //            popularTableView.delegate = self
    //            popularTableView.dataSource = self
    //        }
    
    func configerCollectionViews() {
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        homeCategoriesCollectionView.delegate = self
        homeCategoriesCollectionView.dataSource = self
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
    }
    
    func registerCells() {
        bannerCollectionView.register(UINib(nibName: BannerCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
        homeCategoriesCollectionView.register(UINib(nibName: HomeCategoriesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomeCategoriesCollectionViewCell.identifier)
        productsCollectionView.register(UINib(nibName: HomeProductsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomeProductsCollectionViewCell.identifier)
        popularTableView.register(UINib(nibName: "PopularsTableViewCell", bundle: nil), forCellReuseIdentifier: "PopularsTableViewCell")
        
    }
}

//MARK: - Extentions

extension HomeVC :  UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case bannerCollectionView:
            return viewModel.bannersDataSource.count
        case homeCategoriesCollectionView:
            return viewModel.categoryDataSource.count
        case productsCollectionView:
            return viewModel.productsDataSource.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case bannerCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as! BannerCollectionViewCell
            let banner = viewModel.bannersDataSource[indexPath.row]
            cell.Setup(banner: banner)
            return cell
            
        case homeCategoriesCollectionView:
            let cell = homeCategoriesCollectionView.dequeueReusableCell(withReuseIdentifier: HomeCategoriesCollectionViewCell.identifier, for: indexPath) as! HomeCategoriesCollectionViewCell
            let category = viewModel.categoryDataSource[indexPath.row]
            cell.setup(category: category)
            return cell
            
        case productsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeProductsCollectionViewCell.identifier, for: indexPath) as! HomeProductsCollectionViewCell
            let product = viewModel.productsDataSource[indexPath.row]
            cell.Setup(product: product)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case bannerCollectionView:
            return CGSize(width: UIScreen.main.bounds.width - 20, height: collectionView.collectionViewHeight)
        case homeCategoriesCollectionView:
            let cellWidth: CGFloat = 100
            let cellHeight: CGFloat = 140
            return CGSize(width: cellWidth, height: cellHeight)
        case productsCollectionView:
            return CGSize(width: halfScreenWidth-30, height: collectionView.collectionViewHeight)
            
        default:
            return CGSize(width: 100, height: 100)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case productsCollectionView:
            let selectedProduct = viewModel.productsDataSource[indexPath.item]
            let productId = selectedProduct.id
            coordinator?.displayProductDetailsScreen(productId: productId)
        case homeCategoriesCollectionView:
            let selectedCategorry = viewModel.categoryDataSource[indexPath.item]
            let viewModel = SelectedCategoryViewModel(id: selectedCategorry.id, coordinator: self.coordinator!)
            let selectedCategorryVC = SelectedCategoryViewController(viewModel: viewModel, categoryId: selectedCategorry.id)
            self.navigationController?.pushViewController(selectedCategorryVC, animated: true)
            
        default:
            print("Unknown collection view")
            
        }        
    }
}
//
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return lastNewArrivals.count
//        }
//
//        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            let selectedPopularProduct = popularProduct[indexPath.row]
//            let productDetailsVC = ProductDetailsViewController(id: selectedPopularProduct.id)
//            self.navigationController?.pushViewController(productDetailsVC, animated: true)
//        }
//
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = popularTableView.dequeueReusableCell(withIdentifier: PopularsTableViewCell.identifier, for: indexPath) as! PopularsTableViewCell
//            cell.Setup(Populars: popularProduct[indexPath.row])
//            return cell
//        }
//
//        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            return 100
//        }

// MARK: - VIEW MODEL

private extension HomeVC {
    func bindViewModel() {
        bindIsLoading()
        bindErrorState()
        bindSetupHomeData()
        bindSetupCategories()
    }
    
    func bindIsLoading() {
        viewModel.isLoading.sink { [weak self] isLoading in
            guard let self else { return }
            if isLoading {
                mainContent.isHidden = true
                startLoading()
            } else {
                mainContent.isHidden = false
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
    
    func bindSetupHomeData() {
        viewModel.homeData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] homeData in
                guard let self else { return }
                viewModel.bannersDataSource = homeData.banners
                viewModel.productsDataSource = homeData.products
                bannerCollectionView.reloadData()
                productsCollectionView.reloadData()
                guard let adImageURLString = viewModel.adImageURL?.asUrl else { return }
                homeAdsImageView.kf.setImage(with: adImageURLString)
            }
            .store(in: &cancellable)
    }
    
    func bindSetupCategories() {
        viewModel.categories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] categories in
                self?.viewModel.categoryDataSource = categories.data
                self?.homeCategoriesCollectionView.reloadData()
            }
            .store(in: &cancellable)
    }
}

// MARK: - NewArrivalCollectionViewCellDelegate

extension HomeVC: HomeProductsCollectionViewCellDelegate {
    func didTapFavoriteButton(on cell: HomeProductsCollectionViewCell) {
        AlertViewController.showAlert(on: self, image: UIImage(systemName: "heart.fill")!, title: "Added To Wishlist", message: "Product added to wishlist", buttonTitle: "OK") {
        }
    }
}
