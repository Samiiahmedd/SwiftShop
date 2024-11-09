//
//  Coordinator.swift
//  SwiftShop
//
//  Created by Abdalazem Saleh on 26/10/2024.
//

import UIKit

protocol Coordinator {
    var router: Router { get }
    
    func start()
}

extension Coordinator {
    func dismiss() {
        router.dismiss(animated: true, completion: {})
    }
    
    func pop() {
        router.pop(animated: true, completion: {})
    }    
}
