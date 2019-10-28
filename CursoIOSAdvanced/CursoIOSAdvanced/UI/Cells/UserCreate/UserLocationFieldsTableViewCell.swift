//
//  UserLocationFieldsTableViewCell.swift
//  CursoIOSAdvanced
//
//  Created by David Jardon on 28/10/2019.
//  Copyright © 2019 David Jardon. All rights reserved.
//

import UIKit

class UserLocationFieldsTableViewCell: UITableViewCell {
    static let cellIdentifier = String(describing: UserLocationFieldsTableViewCell.self)
    static let cellHeight: CGFloat = 170

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var fieldCountry: UITextField!
    @IBOutlet weak var fieldState: UITextField!
    @IBOutlet weak var fieldCity: UITextField!
    @IBOutlet weak var fieldStreet: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
