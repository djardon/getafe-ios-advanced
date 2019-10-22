//
//  UserDetailLocationViewCell.swift
//  CursoIOSAdvanced
//
//  Created by David Jardon on 21/10/2019.
//  Copyright © 2019 David Jardon. All rights reserved.
//

import UIKit

class UserDetailLocationViewCell: UITableViewCell {
    static let cellIdentifier = String(describing: UserDetailLocationViewCell.self)
    static let cellHeight: CGFloat = 120

    @IBOutlet weak var mView: UIView!
    @IBOutlet weak var mLabelCountry: UILabel!
    @IBOutlet weak var mLabelState: UILabel!
    @IBOutlet weak var mLabelCountryFlag: UILabel!
    @IBOutlet weak var mLabelStreet: UILabel!
    @IBOutlet weak var mLabelCity: UILabel!
    
    
    override func prepareForReuse() {
        mLabelCountry.text = nil
        mLabelState.text = nil
        mLabelCountryFlag.text = nil
        mLabelStreet.text = nil
        mLabelCity.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mView.layer.cornerRadius = 8.0
        mView.configureShadows()
    }
    
    
    func configure(countryFlag: String? = nil, country: String? = nil, state: String? = nil, street: String? = nil, city: String? = nil) {
        mLabelCountry.text = country
        mLabelState.text = state
        mLabelCountryFlag.text = countryFlag
        mLabelStreet.text = street
        mLabelCity.text = city
    }
}
