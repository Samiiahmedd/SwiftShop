//
//  ProductDetailsViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 07/09/2024.
//

import UIKit

class ProductDetailsViewController: BaseViewController {
    
    //MARK: - IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet var productImage: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productReviews: UILabel!
    @IBOutlet var addToCartButton: UIButton!
    @IBOutlet var favouriteButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var stepperView: StapperView!
    @IBOutlet var secondView: UIView!
    @IBOutlet weak var productFullDescription: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sizeCollectionView: UICollectionView!
    @IBOutlet weak var colorsCollectionView: UICollectionView!
    
    
    //MARK: VARIABLES
    
    var images: [productImages] = []
    var currentPage = 0 {
        didSet{
            pageControl.currentPage = currentPage
        }
    }
    var Size : [SizeModel] = [
        .init(size: "S"),
        .init(size: "M"),
        .init(size: "L"),
        .init(size: "XL"),
        .init(size: "XXL")
    ]
    var colors: [UIColor] = [.red, .black, .lightGray, .green, .orange]
    var selectedColorIndex: Int?
    var selectedSizeIndex: IndexPath?
    
    //MARK: - VIEWLIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        containerView.roundCorners(corners: [.topRight], radius:30 )
        setupView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           tabBarController?.tabBar.isHidden = true
       }

       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           tabBarController?.tabBar.isHidden = false
       }
    
    //MARK: - IBACTIONS
    
    @IBAction func pageControlChanged(_ sender: UIPageControl) {
        let selectedPage = sender.currentPage
        productImage.image = images[selectedPage].image
    }
    
    @IBAction func addToCartButton(_ sender: Any) {
        AlertViewController.showAlert(on: self, image:UIImage(systemName: "cart.fill")! , title: "Added To Cart", message: "product added to cart", buttonTitle: "OK") {
        }
    }
    
    @IBAction func favouriteButton(_ sender: Any) {
        AlertViewController.showAlert(on: self, image:UIImage(systemName: "heart.fill")! , title: "Added To Wishlist", message: "product added to wishlist", buttonTitle: "OK") {
        }
    }
    
    @IBAction func addToCartFooterButton(_ sender: Any) {
        AlertViewController.showAlert(on: self, image:UIImage(systemName: "cart.fill")! , title: "Added To Cart", message: "product added to cart", buttonTitle: "OK") {
        }
    }
}

// MARK: - SETUP VIEW

private extension ProductDetailsViewController {
    
    func setupView() {
        configureNavBar()
        setProductImages()
        configerCollectionViews()
        registerCells()
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
            and: UIImage(named: "back")!) {
                print("Button tapped")
                let search = HomeVC(nibName: "HomeVC", bundle: nil)
                self.navigationController?.pushViewController(search, animated: true)
                self.navigationItem.hidesBackButton = true
            }
        navBar.tintColor = .black
        navBar.backgroundColor = .blue
        
    }
    
    func setProductImages() {
        images = [.init(image: UIImage(named: "productImage1")!),
                  .init(image: UIImage(named: "productImage2")!),
                  .init(image: UIImage(named: "productImage3")!),
        ]
        pageControl.numberOfPages = images.count
        productImage.image = images.first?.image
    }
    
    func configerCollectionViews() {
        sizeCollectionView.delegate = self
        sizeCollectionView.dataSource = self
        colorsCollectionView.delegate = self
        colorsCollectionView.dataSource = self
    }
    
    func registerCells() {
        sizeCollectionView.register(UINib(nibName: SizeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: "SizeCollectionViewCell")
        colorsCollectionView.register(UINib(nibName: ColorCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: "ColorCollectionViewCell")
    }
}

extension ProductDetailsViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case sizeCollectionView:
            return Size.count
        case colorsCollectionView:
            return colors.count
        default:
            return 0
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case sizeCollectionView:
            return configureSizesCell(for: collectionView, with: indexPath)
        case colorsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCollectionViewCell.identifier, for: indexPath) as! ColorCollectionViewCell
            let color = colors[indexPath.row]
            cell.configure(with: color)
            if selectedColorIndex == indexPath.row {
                cell.checkmark.isHidden = false
                cell.containerView.borderWidth = 1
                cell.containerView.borderColor = .black
            } else {
                cell.checkmark.isHidden = true
                cell.containerView.layer.borderWidth = 0
                cell.containerView.layer.borderColor = UIColor.clear.cgColor
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case sizeCollectionView :
            return CGSize(width: 40, height: 40)
        case colorsCollectionView :
            return CGSize(width: 20, height: 20)
        default:
            return CGSize(width: 100, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case  sizeCollectionView:
            selectedSizeIndex = indexPath
            sizeCollectionView.reloadData()
        case colorsCollectionView :
            selectedColorIndex = indexPath.row
            colorsCollectionView.reloadData()
        default:
            return
        }
    }
}

private extension ProductDetailsViewController {
    func configureSizesCell(for collectionView: UICollectionView, with indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SizeCollectionViewCell.identifier, for: indexPath) as! SizeCollectionViewCell
        let sizeModel = Size[indexPath.row]
        cell.sizeLabel.text = sizeModel.size
        if selectedSizeIndex == indexPath {
            cell.sizeView.backgroundColor = .black
            cell.sizeLabel.textColor = .white
        } else {
            cell.sizeView.backgroundColor = .white
            cell.sizeLabel.textColor = .black
        }
        return cell
    }
}


