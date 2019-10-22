//
//  User.swift
//  CursoIOSAdvanced
//
//  Created by David Jardon on 08/10/2019.
//  Copyright © 2019 David Jardon. All rights reserved.
//

import Foundation


class User {
    let id: String
    let avatar: String?
    let firstName: String?
    let lastName: String?
    let email: String?
    let birthdate: Date?
    
    var name: String {
        var userName = ""
        if let userFirstName = firstName {
            userName += userFirstName
        }
        
        if let userLastName = lastName {
            userName += (userName.count > 0 ? " \(userLastName)": userLastName)
        }
        
        return "\(userName)"
    }
    
    init(id: String,
         avatar: String? = nil,
         firstName: String? = nil,
         lastName: String? = nil,
         email: String? = nil,
         birthdate: Date? = nil) {
        
        self.id = id
        self.avatar = avatar
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.birthdate = birthdate
    }
}
