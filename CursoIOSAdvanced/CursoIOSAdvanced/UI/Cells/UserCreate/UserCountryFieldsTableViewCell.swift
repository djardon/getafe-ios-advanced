//
//  UserCountryFieldsTableViewCell.swift
//  CursoIOSAdvanced
//
//  Created by David Jardon on 28/10/2019.
//  Copyright © 2019 David Jardon. All rights reserved.
//

import UIKit

class UserCountryFieldsTableViewCell: UITableViewCell {
    static let cellIdentifier = String(describing: UserCountryFieldsTableViewCell.self)
    static let cellHeight: CGFloat = 170

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var nationalityCollectionView: UICollectionView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
