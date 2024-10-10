//
//  CollectionView+.swift
//  E-Commerce
//
//  Created by Abdalazem Saleh on 05/09/2024.
//

import UIKit

extension UIViewController {
    var fullScreenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }

    var halfScreenWidth: CGFloat {
        return UIScreen.main.bounds.width / 2
    }
}

extension UICollectionView {
    var collectionViewHeight: CGFloat {
        return self.frame.size.height
    }
}
