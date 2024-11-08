//
//  NotificationsTableViewCell.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 03/10/2024.
//

import UIKit

class NotificationsTableViewCell: UITableViewCell {
    
    //MARK: - IBOUTLETS
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var notificationDesc: UILabel!
    @IBOutlet weak var notificationTime: UILabel!
    
    //MARK: - VARIABLES
    static let identifier =  "NotificationsTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "NotificationsTableViewCell", bundle: nil)
    }
}
    
    // MARK: - SETUP CELL
    
    extension NotificationsTableViewCell {
        func Setup(Notification: NotificationsModel) {
            userName.text = Notification.userName
            userImage.image = Notification.userImage
            notificationDesc.text = Notification.notificationDescription
            notificationTime.text = Notification.notificationTime
            
        }
    }

