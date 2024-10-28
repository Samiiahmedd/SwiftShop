//
//  HomeViewModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 04/09/2024.
//

import Foundation
import UIKit
import Combine

//@MainActor
//protocol HomeViewModelProtocol {
//    /// output
//    var isLoading: PassthroughSubject<Bool, Never> { get }
//    var errorMessage: PassthroughSubject<String, Never> { get }
//    var showBanners : PassthroughSubject<String,Never> { get }
//    var showNewArrivals : PassthroughSubject<String,Never> { get }
//    var showPopulars : PassthroughSubject<String,Never> { get }
//
//    /// input
//    var newArrivalCellTriggered: PassthroughSubject<Void, Never> { get }
//    var popularsCellTriggered: PassthroughSubject<Void, Never> { get }
//    var viewAllButtonActionTriggered: PassthroughSubject<Void, Never> { get }
//    var searchButtonActionTriggered: PassthroughSubject<Void, Never> { get }
//    var categoriesButtonActionTriggered: PassthroughSubject<Void, Never> { get }
//    var backActionTriggerd: PassthroughSubject<Void, Never> { get }
//
//
//}

class HomeViewModel {
    //
    //    var coordinator: HomeCoordinatorProtocol
    //    private var cancellable = Set<AnyCancellable>()
    //
    //    var isLoading: PassthroughSubject<Bool, Never> = .init()
    //    var errorMessage: PassthroughSubject<String, Never> = .init()
    //    var showBanners : PassthroughSubject<String,Never> = .init()
    //    var showNewArrivals : PassthroughSubject<String,Never> = .init()
    //    var showPopulars : PassthroughSubject<String,Never> = .init()
    //
    //    var newArrivalCellTriggered: PassthroughSubject<Void, Never> = .init()
    //    var popularsCellTriggered: PassthroughSubject<Void, Never> = .init()
    //    var viewAllButtonActionTriggered: PassthroughSubject<Void, Never> = .init()
    //    var searchButtonActionTriggered: PassthroughSubject<Void, Never> = .init()
    //    var categoriesButtonActionTriggered: PassthroughSubject<Void, Never> = .init()
    //    var backActionTriggerd: PassthroughSubject<Void, Never> = .init()
    //
    //
    //
    //    init(coordinator: HomeCoordinatorProtocol) {
    //        self.coordinator = coordinator
    ////        bindIsHome()
    //    }
    var banners : [BannerModel] = [
        .init(image: UIImage(named: "Banner")!),
        .init(image: UIImage(named: "Banner")!),
        .init(image: UIImage(named: "Banner")!),
        .init(image: UIImage(named: "Banner")!),
    ]
    
    //NewArrival
    @MainActor
    func getNewArrivals(completion:@escaping (Result <[NewArrival], Error>) -> Void) {
        guard let url = URL(string: "https://fakestoreapi.com/products?limit=5") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let newArrivals = try JSONDecoder().decode([NewArrival].self, from: data)
                
                completion(.success(newArrivals))
            }catch{
                print("Error")
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    
    
    //Populars
    @MainActor
    func getPopulars(completion:@escaping (Result <[PopularModel], Error>) -> Void) {
        guard let url = URL(string: "https://fakestoreapi.com/products?sort=desc&limit=7") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let populars = try JSONDecoder().decode([PopularModel].self, from: data)
                
                completion(.success(populars))
            }catch{
                print("Error")
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    
    
}

//extension HomeViewModel : HomeViewModelProtocol {
//    func bindIsHome() {
//        newArrivalCellTriggered
//            .sink { [weak self] _ in self?.login() }
//            .store(in: &cancellable)
//    }
//}
