//
//  SelfSizedUITableView.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 05/09/2024.
//

import Foundation
import UIKit

class SelfSizedUITableView: UITableView {
    
    weak var heightDelegate: UIScrollViewHeightDelegate? // تصحيح الاسم
    
    override var contentSize: CGSize {
        didSet {
            // إعلام الـ delegate بارتفاع المحتوى الجديد دون ضرب بـ zoomScale
            heightDelegate?.scrollView(self, didScrollViewHeightChange: contentSize.height)
        }
    }
}

protocol UIScrollViewHeightDelegate: AnyObject { // تصحيح الاسم
    func scrollView(_ scrollView: UIScrollView, didScrollViewHeightChange height: CGFloat)
}

