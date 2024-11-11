//
//  ProductDetailsViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 07/09/2024.
//

import UIKit
import Kingfisher

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
    var coordinator :HomeCoordinatorProtocol?
    var Product: [PopularModel] = []
    var product: ProductDetailsModel!

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
    var id: Int
    private let viewModel = ProductDetailsViewModel()
    func  setup(productDetails: ProductDetailsModel) {
        productImage.kf.setImage(with: productDetails.image.asUrl)
        productName.text = productDetails.title
        productDescription.text = productDetails.category
        productReviews.text = String(productDetails.rating.count)
        priceLabel.text = "$\(productDetails.price)"
        productReviews.text = String(productDetails.rating.rate)
        productFullDescription.text = productDetails.description

    }
    
    //MARK: - VIEWLIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getProductById()
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func getProductById(){
        viewModel.getNewArrivalsProducts(id: id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let productDetails):
                    self?.setup(productDetails: productDetails)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Initilizer
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - IBACTIONS
    
    @IBAction func pageControlChanged(_ sender: UIPageControl) {
        
    }
    
    @IBAction func addToCartButton(_ sender: Any) {
        AlertViewController.showAlert(on: self, image:UIImage(systemName: "cart.fill")! , title: "Added To Cart", message: "product added to cart", buttonTitle: "OK") {
        }
    }
    
    @IBAction func favouriteButton(_ sender: Any) {
//        AlertViewController.showAlert(on: self, image:UIImage(systemName: "heart.fill")! , title: "Added To Wishlist", message: "product added to wishlist", buttonTitle: "OK") {
//        }
    }
    
    @IBAction func addToCartFooterButton(_ sender: Any) {
            // Check if the product is not nil
            guard let product = product else {
                print("Product is nil")
                return
            }
            saveArticleToCoreData(product: product)
            AlertViewController.showAlert(
                on: self,
                image: UIImage(systemName: "cart.fill")!,
                title: "Added To Cart",
                message: "Product added to cart",
                buttonTitle: "OK") {
            }
        }

    func saveArticleToCoreData(product: ProductDetailsModel) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let savedProduct = WishlistProduct(context: context)
        savedProduct.title = product.title
        savedProduct.category = product.category
        savedProduct.price = product.price
        do {
            try context.save()
            print("Article saved to Core Data")
        } catch {
            print("Failed to save article: \(error.localizedDescription)")
        }
    }
}

// MARK: - SETUP VIEW

private extension ProductDetailsViewController {
    
    func setupView() {
        configureNavBar()
        configerCollectionViews()
        registerCells()
    }
    
    func configureNavBar() {
        
        navBar.setupFirstTralingButton(
            with: "",
            and: UIImage(named: "back")!) { [weak self] in
                guard let self else { return }
                let cartVC = CartViewController(nibName: "CartViewController", bundle: nil)
                self.navigationController?.pushViewController(cartVC, animated: true)
                self.navigationItem.hidesBackButton = true
            }
        
        navBar.setupFirstLeadingButton(
            with: "",
            and: UIImage(named: "back")!) { [weak self] in
                guard let self else { return }
                self.navigationController?.popViewController(animated: true)
                self.navigationItem.hidesBackButton = true
            }
        navBar.lastFirstTralingButton.isHidden = true

        navBar.tintColor = .black
        navBar.backgroundColor = .blue
        
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


