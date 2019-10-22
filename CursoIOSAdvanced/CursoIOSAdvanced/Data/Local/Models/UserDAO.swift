//
//  UserDAO.swift
//  CursoIOSAdvanced
//
//  Created by David Jardon on 04/10/2019.
//  Copyright © 2019 David Jardon. All rights reserved.
//

import Foundation
import RealmSwift

class UserDAO: Object {
    @objc dynamic var uuid: String = ""
    @objc dynamic var avatar: String?
    @objc dynamic var firstname: String?
    @objc dynamic var lastname: String?
    @objc dynamic var email: String?
    @objc dynamic var cell: String?
    @objc dynamic var mobile: String?
    @objc dynamic var gender: String?
    @objc dynamic var birthdate: Date?
    @objc dynamic var country: String?
    @objc dynamic var state: String?
    @objc dynamic var city: String?
    @objc dynamic var street: String?
    @objc dynamic var nationality: String?
    @objc dynamic var latitude: String?
    @objc dynamic var longitude: String?
    
    override static func primaryKey() -> String? {
        return "uuid"
    }
    
    convenience init(uuid: String,
                     avatar: String? = nil,
                     firstname: String? = nil,
                     lastname: String? = nil,
                     email: String? = nil,
                     cell: String? = nil,
                     mobile: String? = nil,
                     gender: String? = nil,
                     birthdate: Date? = nil,
                     country: String? = nil,
                     state: String? = nil,
                     city: String? = nil,
                     street: String? = nil,
                     nationality: String? = nil,
                     latitude: String? = nil,
                     longitude: String? = nil) {
        self.init()
        
        self.uuid = uuid
        self.avatar = avatar
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.cell = cell
        self.mobile = mobile
        self.gender = gender
        self.birthdate = birthdate
        self.country = country
        self.state = state
        self.city = city
        self.street = street
        self.nationality = nationality
        self.latitude = latitude
        self.longitude = longitude
    }
}
