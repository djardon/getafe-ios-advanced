//
//  UserDetail.swift
//  CursoIOSAdvanced
//
//  Created by David Jardon on 21/10/2019.
//  Copyright © 2019 David Jardon. All rights reserved.
//

import Foundation

class UserDetail {
    let id: String
    let avatar: String?
    let firstName: String?
    let lastName: String?
    let gender: String?
    let birthdate: Date?
    let email: String?
    let cell: String?
    let mobile: String?
    let country: String?
    let state: String?
    let city: String?
    let street: String?
    let nationality: String?
    let latitude: String?
    let longitude: String?
    
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
    
    var age: Int {
        guard let date = birthdate,
              let yearAge = Calendar.current.dateComponents([.year],
                                                                  from: date, to: Date()).year else {
            return 0
        }
        
        return yearAge
    }
    
    var countryFlag: String {
        guard let nationalityISO = nationality else {
            return ""
        }
        
        let base : UInt32 = 127397
        var s = ""
        for v in nationalityISO.uppercased().unicodeScalars {
            if let unicode = UnicodeScalar(base + v.value) {
                s.unicodeScalars.append(unicode)
            }
        }
        
        return String(s)
    }
    
    init(id: String, avatar: String? = nil, firstName: String? = nil, lastName: String? = nil, gender: String? = nil, birthdate: Date? = nil, email: String? = nil, cell: String? = nil, mobile: String? = nil, country: String? = nil, state: String? = nil, city: String? = nil, street: String? = nil, nationality: String? = nil, latitude: String? = nil, longitude: String? = nil) {
        
        self.id = id
        self.avatar = avatar
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.birthdate = birthdate
        self.email = email
        self.cell = cell
        self.mobile = mobile
        self.country = country
        self.state = state
        self.city = city
        self.street = street
        self.nationality = nationality
        self.latitude = latitude
        self.longitude = longitude
    }
}
