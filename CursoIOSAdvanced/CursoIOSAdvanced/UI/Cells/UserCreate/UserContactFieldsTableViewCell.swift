//
//  UserContactFieldsTableViewCell.swift
//  CursoIOSAdvanced
//
//  Created by David Jardon on 28/10/2019.
//  Copyright © 2019 David Jardon. All rights reserved.
//

import UIKit

class UserContactFieldsTableViewCell: UITableViewCell {
    static let cellIdentifier = String(describing: UserContactFieldsTableViewCell.self)
    static let cellHeight: CGFloat = 150

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var fieldEmail: UITextField!
    @IBOutlet weak var fieldCell: UITextField!
    @IBOutlet weak var fieldMobile: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
