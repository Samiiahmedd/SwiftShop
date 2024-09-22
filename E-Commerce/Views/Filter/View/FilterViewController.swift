//
//  FilterViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 22/09/2024.
//

import UIKit

class FilterViewController: UIViewController {
    
    //MARK: - IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    //MARK: - VARIABLES
    
    private let viewModel = FilterViewModel()
    var selectedCategoryIndex: IndexPath?

    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }
}

// MARK: - SETUP VIEW

private extension FilterViewController {
    
    func setupView() {
        configureNavBar()
        configureCollectionView()
        registerCells()
    }
    
    func configureNavBar() {
        
        navBar.setupFirstLeadingButton(
            with: "",
            and: UIImage(named: "back")!) {
                print("Button tapped")
                let home = HomeVC(nibName: "HomeVC", bundle: nil)
                self.navigationController?.pushViewController(home, animated: true)
                self.navigationItem.hidesBackButton = true
            }
        navBar.firstTralingButton.isHidden = true
    }
    
    func configureCollectionView() {
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
    }
    
    func registerCells() {
        categoriesCollectionView.register(UINib(nibName: CategoriesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
    }
    
}
//MARK: - Extentions
extension FilterViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoriesCollectionView:
            return viewModel.categories.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case categoriesCollectionView:
            return configureCategoryCell(for: collectionView, with: indexPath)
//            cell.Setup(category: categoryName)
//            return cell
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
            
        default:
            return CGSize(width: 50, height: 50)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case  categoriesCollectionView:
            selectedCategoryIndex = indexPath
            categoriesCollectionView.reloadData()
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
}
