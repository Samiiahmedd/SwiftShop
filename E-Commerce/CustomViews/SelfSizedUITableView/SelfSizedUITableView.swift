//
//  SelfSizedUITableView.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 05/09/2024.
//

import Foundation
import UIKit

class SelfSizedTableView: UITableView {
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
    }
    
    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
}
