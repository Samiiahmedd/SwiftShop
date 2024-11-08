//
//  FilterViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 22/09/2024.
//

import UIKit

class FilterViewController: BaseViewController {
    
    //MARK: - IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    @IBOutlet weak var sortCollectionView: UICollectionView!
    
    @IBOutlet var starsButton: [UIButton]!
    
    
    //MARK: - VARIABLES
    
    private let viewModel = FilterViewModel()
    var selectedCategoryIndex: IndexPath?
    var selectedSortIndex: IndexPath?
    var selectedButton: UIButton?
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    //@obj func
    @objc func checkmarkButtonTapped(_ sender: UIButton) {
        if let selectedButton = starsButton.first(where: { $0.isSelected }) {
            selectedButton.isSelected = false
            selectedButton.tintColor = .clear
        }
        sender.isSelected = true
        sender.tintColor = .black
    }
}

// MARK: - SETUP VIEW

private extension FilterViewController {
    func setupView() {
        configureNavBar()
        configureCollectionView()
        registerCells()
        setButtonsCheckMark()
    }
    
    func configureNavBar() {
        navBar.setupFirstLeadingButton(
            with: "",
            and: UIImage(named: "back")!) {
                self.navigationController?.popViewController(animated: true)
            }
        navBar.firstTralingButton.isHidden = true
        navBar.lastFirstTralingButton.isHidden = true
    }
    
    func configureCollectionView() {
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        sortCollectionView.delegate = self
        sortCollectionView.dataSource = self
    }
    
    func registerCells() {
        categoriesCollectionView.register(UINib(nibName: CategoriesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        
        sortCollectionView.register(UINib(nibName: CategoriesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
    }
    
    func setButtonsCheckMark() {
        for button in starsButton {
            button.setImage(UIImage(systemName: "circle"), for: .normal)
            button.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
            button.tintColor = .clear
            button.addTarget(self, action: #selector(checkmarkButtonTapped(_:)), for: .touchUpInside)
        }
    }
}

//MARK: - Extentions

extension FilterViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoriesCollectionView:
            return viewModel.categories.count
        case sortCollectionView:
            return viewModel.sortBy.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case categoriesCollectionView:
            return configureCategoryCell(for: collectionView, with: indexPath)
        case sortCollectionView:
            return configureSortByCell(for: collectionView, with: indexPath)
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case categoriesCollectionView:
            let category = viewModel.categories[indexPath.row]
            let label = UILabel()
            label.text = category.categoryName
            label.font = UIFont.systemFont(ofSize: 12)
            label.sizeToFit()
            let textWidth = label.frame.width + 32
            let textHeight = label.frame.height + 16
            return CGSize(width: textWidth, height: textHeight)
            
        case sortCollectionView:
            let sortBy = viewModel.sortBy[indexPath.row]
            let label = UILabel()
            label.text = sortBy.name
            label.font = UIFont.systemFont(ofSize: 12)
            label.sizeToFit()
            let textWidth = label.frame.width + 34
            let textHeight = label.frame.height + 18
            return CGSize(width: textWidth, height: textHeight)
        default:
            return CGSize(width: 50, height: 50)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case  categoriesCollectionView:
            selectedCategoryIndex = indexPath
            categoriesCollectionView.reloadData()
        case sortCollectionView:
            selectedSortIndex = indexPath
            sortCollectionView.reloadData()
        default:
            return
        }
    }
    
}

private extension FilterViewController {
    func configureCategoryCell(for collectionView: UICollectionView, with indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: indexPath) as! CategoriesCollectionViewCell
        let categoryName = viewModel.categories[indexPath.row]
        cell.categoryName.text = categoryName.categoryName
        if selectedCategoryIndex == indexPath {
            cell.mainView.backgroundColor = .black
            cell.categoryName.textColor = .white
        } else {
            cell.mainView.backgroundColor = .white
            cell.categoryName.textColor = .black
            cell.mainView.borderColor = .lightGray
            cell.mainView.borderWidth = 1
            
        }
        return cell
    }
    
    func configureSortByCell (for collectionView: UICollectionView, with indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: indexPath) as! CategoriesCollectionViewCell
        let sortBy = viewModel.sortBy[indexPath.row]
        cell.categoryName.text = sortBy.name
        if selectedSortIndex == indexPath {
            cell.mainView.backgroundColor = .black
            cell.categoryName.textColor = .white
        } else {
            cell.mainView.backgroundColor = .white
            cell.categoryName.textColor = .black
            cell.mainView.borderColor = .lightGray
            cell.mainView.borderWidth = 1
        }
        return cell
    }
}
