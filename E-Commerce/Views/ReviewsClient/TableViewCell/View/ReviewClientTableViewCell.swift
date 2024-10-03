//
//  ReviewClientTableViewCell.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 02/10/2024.
//

import UIKit

class ReviewClientTableViewCell: UITableViewCell {
    
    //MARK: - IBOUTLETS
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var ratingDate: UILabel!
    @IBOutlet weak var ratingDescription: UILabel!
    
    //MARK: - VARIABLES
    
    static let identifier =  "ReviewClientTableViewCell"
    static func nib() -> UINib {
           return UINib(nibName: "ReviewClientTableViewCell", bundle: nil)
       }
    
    //MARK: - VIEW LIFE CYCLE

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}

// MARK: - SETUP CELL

extension ReviewClientTableViewCell {
    func Setup(Reviews: ReviewClientModel) {
        userName.text = Reviews.userName
        userImage.image = Reviews.userImage
        ratingDate.text = Reviews.reviewDate
        ratingDescription.text = Reviews.reviewDescription
    }
}
