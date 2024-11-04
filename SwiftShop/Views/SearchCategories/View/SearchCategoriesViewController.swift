//
//  SearchCategoriesViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 05/09/2024.
//

import UIKit

class SearchCategoriesViewController: UIViewController {
    
    //MARK: - IBoutlet
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet var searchCategoriesCollectionView: UICollectionView!
    
    @IBOutlet weak var SearchView: UIView!
    //MARK: - Variables
    
    let viewModel = SearchCategoriesViewModel()
    var categoriesList: [String] = []
    
    //MARK: - ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        Task {
                   await fetchCategories()
               }
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
                print("Button tapped")
                let home = HomeVC(nibName: "HomeVC", bundle: nil)
                self.navigationController?.pushViewController(home, animated: true)
            }
        navBar.firstTralingButton.isHidden = true
    }
    
    func configerCollectionViews() {
        searchCategoriesCollectionView.delegate = self
        searchCategoriesCollectionView.dataSource = self
    }
    
    func registerCells() {
        searchCategoriesCollectionView.register(UINib(nibName: SearchCategoriesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SearchCategoriesCollectionViewCell.identifier)
    }
    
    private func fetchCategories() async {
            do {
                let categories = try await viewModel.getCategoriesList()
                categoriesList = categories // Assign the fetched categories to the list
                DispatchQueue.main.async {
                    self.searchCategoriesCollectionView.reloadData()
                }
            } catch {
                print("Error fetching categories: \(error.localizedDescription)")
            }
        }
    }




//MARK: - EXTENTIONS

extension SearchCategoriesViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = searchCategoriesCollectionView.dequeueReusableCell(withReuseIdentifier: SearchCategoriesCollectionViewCell.identifier, for: indexPath) as! SearchCategoriesCollectionViewCell
            let category = categoriesList[indexPath.row]
            cell.setup(category: category) // Update the setup call to use String directly
            return cell
        }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width) - 40 , height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}
