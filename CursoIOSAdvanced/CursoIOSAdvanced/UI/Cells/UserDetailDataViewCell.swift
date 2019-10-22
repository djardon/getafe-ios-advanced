//
//  UserDetailDataViewCell.swift
//  CursoIOSAdvanced
//
//  Created by David Jardon on 21/10/2019.
//  Copyright © 2019 David Jardon. All rights reserved.
//

import UIKit
import Kingfisher

class UserDetailDataViewCell: UITableViewCell {
    static let cellIdentifier = String(describing: UserDetailDataViewCell.self)
    static let cellHeight: CGFloat = 200
    
    @IBOutlet weak var mView: UIView!
    @IBOutlet weak var mImage: UIImageView!
    @IBOutlet weak var mLabelName: UILabel!
    @IBOutlet weak var mLabelSurname: UILabel!
    @IBOutlet weak var mLabelGender: UILabel!
    @IBOutlet weak var mLabelBirthdate: UILabel!
    @IBOutlet weak var mLabelAge: UILabel!

    
    override func prepareForReuse() {
        mImage.image = nil
        mLabelName.text = nil
        mLabelSurname.text = nil
        mLabelGender.text = nil
        mLabelBirthdate.text = nil
        mLabelAge.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mView.layer.cornerRadius = 8.0
        mView.configureShadows()
    }

    func configure(image: String? = nil, name: String? = nil, surname: String? = nil, gender: String? = nil, birthdate: Date? = nil, age: Int? = nil) {
        let url = URL(string: image ?? "")
        mImage.kf.setImage(with: url)
        mLabelName.text = name
        mLabelSurname.text = surname
        mLabelGender.text = gender
        mLabelAge.text = "\(age ?? 0)"

        if let birthdateValue = birthdate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            mLabelBirthdate.text = dateFormatter.string(from: birthdateValue)
        }
    }
}
