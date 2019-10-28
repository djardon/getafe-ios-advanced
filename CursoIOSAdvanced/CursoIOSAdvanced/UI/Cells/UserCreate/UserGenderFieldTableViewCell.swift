//
//  UserGenderFieldTableViewCell.swift
//  CursoIOSAdvanced
//
//  Created by David Jardon on 28/10/2019.
//  Copyright © 2019 David Jardon. All rights reserved.
//

import UIKit

class UserGenderFieldTableViewCell: UITableViewCell {
    static let cellIdentifier = String(describing: UserGenderFieldTableViewCell.self)
    static let cellHeight: CGFloat = 100

    @IBOutlet weak var genderSelector: UISegmentedControl!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
