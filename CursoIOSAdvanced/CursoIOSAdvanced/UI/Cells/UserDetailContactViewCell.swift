//
//  UserDetailContactViewCell.swift
//  CursoIOSAdvanced
//
//  Created by David Jardon on 21/10/2019.
//  Copyright © 2019 David Jardon. All rights reserved.
//

import UIKit

class UserDetailContactViewCell: UITableViewCell {
    static let cellIdentifier = String(describing: UserDetailContactViewCell.self)
    static let cellHeight: CGFloat = 120

    
    @IBOutlet weak var mView: UIView!
    @IBOutlet weak var mLabelEmail: UILabel!
    @IBOutlet weak var mLabelCell: UILabel!
    @IBOutlet weak var mLabelMobile: UILabel!
    
    
    override func prepareForReuse() {
        mLabelEmail.text = nil
        mLabelMobile.text = nil
        mLabelCell.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mView.layer.cornerRadius = 8.0
        mView.configureShadows()
    }

    func configure(email: String? = nil, cell: String? = nil, mobile: String? = nil) {
        mLabelEmail.text = email
        mLabelMobile.text = mobile
        mLabelCell.text = cell
    }
}
