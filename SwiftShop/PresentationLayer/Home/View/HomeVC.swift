//
//  HomeVC.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 30/08/2024.
//

import UIKit
import Combine
import Kingfisher

class HomeVC: BaseViewController{
    
    //MARK: - IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var popularTableView: SelfSizedTableView!
    @IBOutlet weak var homeAdsImageView: UIImageView!
    
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
        fetchAllProducts()        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationItem.hidesBackButton = true
    }
    
    
    //MARK: - @IBACTIONS
    
    @IBAction func viewAllNewArrivalsButtonAvtion(_ sender: Any) {
        let viewAllProducts = ProductCollectionViewController(nibName: "ProductCollectionViewController", bundle: nil)
        viewAllProducts.labelTitle = "All Products"
        self.navigationController?.pushViewController(viewAllProducts, animated: true)
        self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func viewAllPopularsButtonAction(_ sender: Any) {
        let allPopularsVC = ProductCollectionViewController(nibName: "ProductCollectionViewController", bundle: nil)
        allPopularsVC.labelTitle = "Populars"
        self.navigationController?.pushViewController(allPopularsVC, animated: true)
        self.navigationItem.hidesBackButton = true
    }
    
    //MARK: - FUNCTIONS
    private func fetchAllProducts() {
        viewModel.getHomeProducts()
        func fetchAndDisplayProducts() {
            let services = ProductServices()
            services.getHomeProducts()
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("Data fetch completed") // Debug
                    case .failure(let error):
                        print("Error fetching data: \(error.localizedDescription)")
                    }
                } receiveValue: { [weak self] homeData in
                    print("Fetched data with \(homeData.banners.count) banners and \(homeData.products.count) products")
                    self?.viewModel.bannersDataSource = homeData.banners
                    self?.viewModel.productsDataSource = homeData.products
                    self?.bannerCollectionView.reloadData()
                    self?.productsCollectionView.reloadData()
                    
                    if let adImageURLString = self?.viewModel.adImageURL?.asUrl {
                        self?.homeAdsImageView.kf.setImage(with: adImageURLString)
                    } else {
                        print("Invalid ad image URL")
                    }
                }
                .store(in: &cancellable)
        }
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
            and: UIImage(systemName: "magnifyingglass")!) {
                let filter = FilterViewController(nibName: "FilterViewController", bundle: nil)
                self.navigationController?.pushViewController(filter, animated: true)
                self.navigationItem.hidesBackButton = true
            }
        
        navBar.setupLastFirstTralingButton(with: "", and: UIImage(named: "cart")!) {
            let cartVC = CartViewController(nibName: "CartViewController", bundle: nil)
            self.navigationController?.pushViewController(cartVC, animated: true)
            self.navigationItem.hidesBackButton = true
        }
        
        navBar.setupFirstLeadingButton(
            with: "",
            and: UIImage(named: "menu")!) {
                let search = SearchCategoriesViewController(nibName: "SearchCategoriesViewController", bundle: nil)
                self.navigationController?.pushViewController(search, animated: true)
                self.navigationItem.hidesBackButton = true
            }
        navBar.tintColor = .black
        
    }
    
    //        func configureTableViews() {
    //            popularTableView.delegate = self
    //            popularTableView.dataSource = self
    //        }
    
    func configerCollectionViews() {
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
    }
    
    func registerCells() {
        bannerCollectionView.register(UINib(nibName: BannerCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
        productsCollectionView.register(UINib(nibName: NewArriivalCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: NewArriivalCollectionViewCell.identifier)
        
        popularTableView.register(UINib(nibName: "PopularsTableViewCell", bundle: nil), forCellReuseIdentifier: "PopularsTableViewCell")
    }
}

//MARK: - Extentions

extension HomeVC :  UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case bannerCollectionView:
            print("Number of banners: \(viewModel.bannersDataSource.count)") // Debug
            return viewModel.bannersDataSource.count
        case productsCollectionView:
            print("Number of products: \(viewModel.productsDataSource.count)") // Debug
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
            
        case productsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewArriivalCollectionViewCell.identifier, for: indexPath) as! NewArriivalCollectionViewCell
            let product = viewModel.productsDataSource[indexPath.row]
            cell.Setup(newArrival: product)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case bannerCollectionView:
            return CGSize(width: fullScreenWidth-100, height: collectionView.collectionViewHeight)
            
        case productsCollectionView:
            return CGSize(width: halfScreenWidth-30, height: collectionView.collectionViewHeight)
            
        default:
            return CGSize(width: 100, height: 100)
        }
    }
    
    
    //        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //            let selectedProduct = lastNewArrivals[indexPath.item]
    //            let productDetailsVC = ProductDetailsViewController(id: selectedProduct.id)
    //            self.navigationController?.pushViewController(productDetailsVC, animated: true)
    //        }
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
}

// MARK: - VIEW MODEL

private extension HomeVC {
    func bindViewModel() {
        bindIsLoading()
        bindErrorState()
        bindSetupView()
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
    
    func bindSetupView() {
        viewModel.homeData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] homeData in
                print("Updating data sources in HomeVC with \(homeData.banners.count) banners and \(homeData.products.count) products") // Debug
                self?.viewModel.bannersDataSource = homeData.banners
                self?.viewModel.productsDataSource = homeData.products
                self?.bannerCollectionView.reloadData()
                self?.productsCollectionView.reloadData()
            }
            .store(in: &cancellable)
    }
}

// MARK: - NewArrivalCollectionViewCellDelegate

extension HomeVC: NewArrivalCollectionViewCellDelegate {
    func didTapFavoriteButton(on cell: NewArriivalCollectionViewCell) {
        AlertViewController.showAlert(on: self, image: UIImage(systemName: "heart.fill")!, title: "Added To Wishlist", message: "Product added to wishlist", buttonTitle: "OK") {
        }
    }
}
