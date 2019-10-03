//
//  UIView+Utils.swift
//  CursoIOSAdvanced
//
//  Created by David Jardon on 03/10/2019.
//  Copyright © 2019 David Jardon. All rights reserved.
//

import UIKit

extension UIView {
    func configureShadows(color: UIColor = UIColor.lightGray,
                          opacity: Float = 0.6,
                          radius: CGFloat = 4.0,
                          offset: CGSize = CGSize.zero) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}
