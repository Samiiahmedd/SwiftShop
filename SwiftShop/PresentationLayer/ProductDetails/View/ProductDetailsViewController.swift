//
//  ProductDetailsViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 07/09/2024.
//

import UIKit
import Combine
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
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var sizeCollectionView: UICollectionView!
    @IBOutlet weak var colorsCollectionView: UICollectionView!
    
    //MARK: VARIABLES
    
    private var viewModel: ProductDetailsViewModel
    private var cancellable = Set<AnyCancellable>()
    var coordinator :HomeCoordinatorProtocol?
    var selectedColorIndex: Int?
    var selectedSizeIndex: IndexPath?
    private let productId: Int
    var currentPage = 0 {
        didSet{
            pageControl.currentPage = currentPage
        }
    }
    
    //MARK: - INITIALIZER
    
    init(viewModel: ProductDetailsViewModel, productId: Int) {
        self.viewModel = viewModel
        self.productId = productId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - VIEWLIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModel()
        startShimmerEffect()
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
        AlertViewController.showAlert(
            on: self,
            image: UIImage(systemName: "cart.fill")!,
            title: "Added To Cart",
            message: "Product added to cart",
            buttonTitle: "OK") {
            }
    }
    
    //MARK: - FUNCTIONS
    
    private func startShimmerEffect() {
        productImage.startShimmering()
        productName.startShimmering()
        productDescription.startShimmering()
        priceLabel.startShimmering()
        oldPriceLabel.startShimmering()
        colorsCollectionView.startShimmering()
        sizeCollectionView.startShimmering()
    }
    
    private func stopShimmerEffect() {
        productImage.stopShimmering()
        productName.stopShimmering()
        productDescription.stopShimmering()
        priceLabel.stopShimmering()
        oldPriceLabel.stopShimmering()
//        colorsCollectionView.stopShimmering()
//        sizeCollectionView.stopShimmering()
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
            and: UIImage(named: "cart")!) { [weak self] in
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
    
    private func setup(_ productDetails: ProductDetails) {
        productImage.kf.setImage(with: productDetails.image.asUrl)
        productName.text = productDetails.name
        productDescription.text = productDetails.description
        priceLabel.text = "$\(productDetails.price)"
        oldPriceLabel.text =  "$\(productDetails.old_price)"
        productFullDescription.text = productDetails.description
        let oldPriceText = "$\(productDetails.old_price)"
        let attributedOldPrice = NSAttributedString(
            string: oldPriceText,
            attributes: [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                .strikethroughColor: UIColor.red
            ]
        )
        oldPriceLabel.attributedText = attributedOldPrice
        priceLabel.text = "$\(productDetails.price)"
        
    }
}

//MARK: - SETUP VIEW MODEl

private extension ProductDetailsViewController {
    func setupViewModel() {
        fetchProductDetails()
        bindViewModel()
    }
    
    private func fetchProductDetails() {
        viewModel.getProductDetails()
    }
    
    private func bindViewModel() {
        viewModel.ProductDetails
            .receive(on: DispatchQueue.main)
            .sink { [weak self] productDetails in
                self?.stopShimmerEffect()
                self?.setup(productDetails)
            }
            .store(in: &cancellable)
        
        viewModel.errorMessage
            .sink { [weak self] errorMessage in
                self?.stopShimmerEffect()
                self?.showErrorAlert(message: errorMessage)
            }
            .store(in: &cancellable)
    }
}

//MARK: - CollectionViews

extension ProductDetailsViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case sizeCollectionView:
            return viewModel.sizes.count
        case colorsCollectionView:
            return viewModel.colors.count
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
            let color = viewModel.colors[indexPath.row]
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
        let sizeModel = viewModel.sizes[indexPath.row]
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




