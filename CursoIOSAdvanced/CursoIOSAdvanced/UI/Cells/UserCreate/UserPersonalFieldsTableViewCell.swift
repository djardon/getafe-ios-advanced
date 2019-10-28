//
//  UserPersonalFieldsTableViewCell.swift
//  CursoIOSAdvanced
//
//  Created by David Jardon on 28/10/2019.
//  Copyright © 2019 David Jardon. All rights reserved.
//

import UIKit

class UserPersonalFieldsTableViewCell: UITableViewCell {
    static let cellIdentifier = String(describing: UserPersonalFieldsTableViewCell.self)
    static let cellHeight: CGFloat = 200

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var fieldFirstname: UITextField!
    @IBOutlet weak var fieldLastname: UITextField!
    @IBOutlet weak var avatarImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
