//
//  ReviewsClientViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 02/10/2024.
//

import UIKit

class ReviewsClientViewController: UIViewController {
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var reviewsTableView: UITableView!
    
    //MARK: - VARIABLES
    
    var viewModel = ReviewsClientViewModel()

    //MARK: - VIEW LIFE CYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - SETUP VIEW

private extension ReviewsClientViewController {
    
    func setupView() {
        configureNavBar()
        configureTableViews()
        registerCells()
    }
    
    func configureNavBar() {
        navBar.setupFirstTralingButton(
            with: "",
            and:UIImage(named: "cart")!)
        {
            print("Button tapped")
            
        }
        
        navBar.setupFirstLeadingButton(
            with: "",
            and: UIImage(named: "back")!) {
                print("Button tapped")
            }
        navBar.tintColor = .black
        
    }
    
    func configureTableViews() {
        reviewsTableView.delegate = self
        reviewsTableView.dataSource = self
    }
    
    func registerCells() {
        reviewsTableView.register(UINib(nibName: "ReviewClientTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewClientTableViewCell")
    }
}

//MARK: - EXTENSION

extension ReviewsClientViewController :  UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reviewsTableView.dequeueReusableCell(withIdentifier: ReviewClientTableViewCell.identifier, for: indexPath) as! ReviewClientTableViewCell
        let Reviews = viewModel.Reviews[indexPath.row]
        cell.Setup(Reviews: Reviews)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.Reviews.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
