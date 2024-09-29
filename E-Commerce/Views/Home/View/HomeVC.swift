//
//  HomeVC.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 30/08/2024.
//

import UIKit

class HomeVC: UIViewController{
    
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
    
    //MARK: - viewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the default navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationItem.hidesBackButton = true
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
                print("Button tapped")
                let filter = FilterViewController(nibName: "FilterViewController", bundle: nil)
                self.navigationController?.pushViewController(filter, animated: true)
                self.navigationItem.hidesBackButton = true
            }
        
        navBar.setupFirstLeadingButton(
            with: "",
            and: UIImage(named: "menu")!) {
                print("Button tapped")
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
            return viewModel.newArrivals.count
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
            let newArrival = viewModel.newArrivals[indexPath.row]
            cell.Setup(newArrival: newArrival)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case bannerCollectionView:
            return CGSize(width: fullScreenWidth-40, height: collectionView.collectionViewHeight)
            
        case newArriivalCollectionView:
            return CGSize(width: halfScreenWidth - 40, height: collectionView.collectionViewHeight)
            
        default:
            return CGSize(width: 100, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailedScreen = ProductDetailsViewController()
        self.navigationController?.pushViewController(detailedScreen, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.popular.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = popularTableView.dequeueReusableCell(withIdentifier: PopularsTableViewCell.identifier, for: indexPath) as! PopularsTableViewCell
        let PopularsSection = viewModel.popular[indexPath.row]
        cell.Setup(Populars: PopularsSection)
        return cell
    }
    
    
    
}
