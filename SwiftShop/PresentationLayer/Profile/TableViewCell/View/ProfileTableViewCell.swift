//
//  ProfileTableViewCell.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 08/10/2024.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    //MARK: - @IBOUTLETS
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var mainView: UIView!
    
    // MARK: - VARIABLES
    
    static let identifier = "ProfileTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "ProfileTableViewCell", bundle: nil)
    }
    
    //MARK: - VIEW LIFE CYCLE
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
}

// MARK: - SETUP CELL

extension ProfileTableViewCell {
    func Setup (ProfileCell:ProfileTableViewCellModel) {
        photo.image = ProfileCell.image
        title.text = ProfileCell.title
    }
}
