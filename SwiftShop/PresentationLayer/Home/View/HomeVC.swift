//
//  HomeVC.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 30/08/2024.
//

import UIKit

class HomeVC: BaseViewController{
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var newArriivalCollectionView: UICollectionView!
    @IBOutlet weak var popularTableView: SelfSizedTableView!
    
    // MARK: - Variables
    
    private let viewModel = HomeViewModel()
    var path: String = ""
    var lastNewArrivals: [NewArrival] = []
    var popularProduct: [PopularModel] = []
    var product : [ProductDetailsModel] = []
    
    //MARK: - viewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchNewArrivals()
        fetchPopulars()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationItem.hidesBackButton = true
    }
    
    //MARK: - @IBACTIONS
    
    @IBAction func viewAllNewArrivalsButtonAvtion(_ sender: Any) {
        let allNewArrivalsVC = ProductCollectionViewController(nibName: "ProductCollectionViewController", bundle: nil)
        allNewArrivalsVC.labelTitle = "New Arrivals"
        self.navigationController?.pushViewController(allNewArrivalsVC, animated: true)
        self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func viewAllPopularsButtonAction(_ sender: Any) {
        let allPopularsVC = ProductCollectionViewController(nibName: "ProductCollectionViewController", bundle: nil)
        allPopularsVC.labelTitle = "Populars"
        self.navigationController?.pushViewController(allPopularsVC, animated: true)
        self.navigationItem.hidesBackButton = true
    }
    
    /// New Arrivals
    private func fetchNewArrivals() {
        viewModel.getNewArrivals { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.lastNewArrivals = data
                    self?.newArriivalCollectionView.reloadData()
                case .failure(let error):
                    print("Failed to fetch new arrivals: \(error.localizedDescription)")
                }
            }
        }
    } 
    
    // Populars
    @MainActor
    private func fetchPopulars() {
        viewModel.getPopulars { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.popularProduct  = data
                    self?.popularTableView.reloadData()
                case .failure(let error):
                    print("Failed to fetch populars: \(error.localizedDescription)")
                }
            }
        }
    }
}

// MARK: - SETUP VIEW

private extension HomeVC {
    
    func setupView() {
        configerCollectionViews()
        configureTableViews()
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
    
    func configureTableViews() {
        popularTableView.delegate = self
        popularTableView.dataSource = self
    }
    
    func configerCollectionViews() {
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        newArriivalCollectionView.delegate = self
        newArriivalCollectionView.dataSource = self
    }
    
    func registerCells() {
        bannerCollectionView.register(UINib(nibName: BannerCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
        newArriivalCollectionView.register(UINib(nibName: NewArriivalCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: NewArriivalCollectionViewCell.identifier)
        popularTableView.register(UINib(nibName: "PopularsTableViewCell", bundle: nil), forCellReuseIdentifier: "PopularsTableViewCell")
    }
}

//MARK: - Extentions

extension HomeVC :  UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case bannerCollectionView:
            return viewModel.banners.count
        case newArriivalCollectionView :
            return lastNewArrivals.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case bannerCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as! BannerCollectionViewCell
            let banner = viewModel.banners[indexPath.row]
            cell.Setup(banner: banner)
            return cell
            
        case newArriivalCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewArriivalCollectionViewCell.identifier, for: indexPath) as! NewArriivalCollectionViewCell
            cell.Setup(newArrival: lastNewArrivals[indexPath.row])
            cell.delegate = self
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case bannerCollectionView:
            return CGSize(width: fullScreenWidth-100, height: collectionView.collectionViewHeight)
            
        case newArriivalCollectionView:
            return CGSize(width: halfScreenWidth-30, height: collectionView.collectionViewHeight)
            
        default:
            return CGSize(width: 100, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedProduct = lastNewArrivals[indexPath.item]
        let productDetailsVC = ProductDetailsViewController(id: selectedProduct.id)
        self.navigationController?.pushViewController(productDetailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lastNewArrivals.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPopularProduct = popularProduct[indexPath.row]
        let productDetailsVC = ProductDetailsViewController(id: selectedPopularProduct.id)
        self.navigationController?.pushViewController(productDetailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = popularTableView.dequeueReusableCell(withIdentifier: PopularsTableViewCell.identifier, for: indexPath) as! PopularsTableViewCell
        cell.Setup(Populars: popularProduct[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - NewArrivalCollectionViewCellDelegate

extension HomeVC: NewArrivalCollectionViewCellDelegate {
    func didTapFavoriteButton(on cell: NewArriivalCollectionViewCell) {
        AlertViewController.showAlert(on: self, image: UIImage(systemName: "heart.fill")!, title: "Added To Wishlist", message: "Product added to wishlist", buttonTitle: "OK") {
        }
    }
}