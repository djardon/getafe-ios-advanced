//
//  UserBirthdateTableViewCell.swift
//  CursoIOSAdvanced
//
//  Created by David Jardon on 28/10/2019.
//  Copyright © 2019 David Jardon. All rights reserved.
//

import UIKit

class UserBirthdateTableViewCell: UITableViewCell {
    static let cellIdentifier = String(describing: UserBirthdateTableViewCell.self)
    static let cellHeight: CGFloat = 175
    

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
