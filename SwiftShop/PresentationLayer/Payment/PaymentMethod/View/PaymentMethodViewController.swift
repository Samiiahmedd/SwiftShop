//
//  PaymentMethodController.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 11/10/2024.
//

import UIKit
import Combine

class PaymentMethodViewController: UIViewController {
    
    //MARK: - IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    
    @IBOutlet weak var paymentTableView: UITableView!
    
    //MARK: - VARIABLES
    
    var selectedMethodIndex: IndexPath?
    
    private var viewModel: PaymentMethodViewModel
    private var cancellable = Set<AnyCancellable>()
    var coordinator: HomeCoordinatorProtocol?
    
    //MARK: - INITIALIZER
    
    init(viewModel: PaymentMethodViewModel) {
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
    }
}

//MARK: - SETUP VIEW

extension PaymentMethodViewController {
    
    func setupView() {
        configureNavBar()
        configureTableView()
        registerCell()
        
    }
    
    func configureNavBar() {
        navBar.setupFirstLeadingButton(with: "", and: UIImage(named: "back")!) { [self] in
            coordinator?.pop()
        }
        navBar.firstTralingButton.isHidden = true
        navBar.lastFirstTralingButton.isHidden = true
    }
    
    func configureTableView() {
        paymentTableView.dataSource = self
        paymentTableView.delegate = self
        
    }
    
    func registerCell() {
        paymentTableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
    }
}

///TableView
extension PaymentMethodViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.paymentMethod.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = paymentTableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
        let payment = viewModel.paymentMethod[indexPath.row]
        cell.Setup(ProfileCell: payment)
        
        if selectedMethodIndex == indexPath {
            cell.mainView.backgroundColor = .black
            cell.title.textColor = .white
            cell.mainView.borderColor = .black
            cell.mainView.borderWidth = 1
            cell.arrow.image = UIImage(systemName: "circle.inset.filled")
            cell.arrow.tintColor = .white
        } else {
            cell.mainView.backgroundColor = .white
            cell.title.textColor = .black
            cell.mainView.borderColor = .white
            cell.arrow.image = UIImage(systemName: "circle")
            cell.arrow.tintColor = .gray
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.cornerRadius = 16
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.1
        cell.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.layer.shadowRadius = 12
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: 16).cgPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMethodIndex = indexPath
        if indexPath.row == 0 {
            coordinator!.displayCardEnter()
        } else if indexPath.row == 1 {
            print("OrderDetails")
        }
        tableView.reloadData()
    }
}
