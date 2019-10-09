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
    let country: String?
    let nationality: String?
    
    var name: String {
        return "\(String(describing: firstName)) \(String(describing: lastName))"
    }
    
    var age: Int {
        guard let date = birthdate,
              let yearAge = Calendar.current.dateComponents([.year],
                                                                  from: date, to: Date()).year else {
            return 0
        }
        
        return yearAge
    }
    
    
    
    init(id: String, avatar: String? = nil, firstName: String? = nil, lastName: String? = nil, email: String? = nil, birthdate: Date? = nil, country: String? = nil, nationality: String? = nil) {
        
        self.id = id
        self.avatar = avatar
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.birthdate = birthdate
        self.country = country
        self.nationality = nationality
    }
    
}
