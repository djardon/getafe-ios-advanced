//
//  DatabaseManager.swift
//  CursoIOSAdvanced
//
//  Created by David Jardon on 07/10/2019.
//  Copyright © 2019 David Jardon. All rights reserved.
//

import Foundation
import RealmSwift


class DatabaseManager {
    // MARK: - Singleton declaration
    static let shared = DatabaseManager()
    private init() {}

    // MARK: - Properties
    // Get the default Realm database
    private var realm: Realm {
        return try! Realm()
    }
}


// MARK: - Realm
extension DatabaseManager {
    var users: Results<UserDAO> {
        return realm.objects(UserDAO.self)
    }
    
    func save(user: UserDAO) {
        try! realm.write {
            realm.add(user,
                      update: .modified)
        }
    }
    
    func user(by id: String) -> UserDAO? {
        return realm.object(ofType: UserDAO.self,
                            forPrimaryKey: id)
    }
    
    func deleteAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func delete(user: UserDAO) {
        try! realm.write {
            realm.delete(user)
        }
    }
}

// MARK: - UserDefaults
extension DatabaseManager {
    var KEY_OPTION_SELECTED: String {
        return "KEY_OPTION_SELECTED"
    }
    
    var optionSelected: Int {
        return UserDefaults.standard.integer(forKey: KEY_OPTION_SELECTED)
    }
    
    func save(option: Int) {
        UserDefaults.standard.set(option,
                                  forKey: KEY_OPTION_SELECTED)
    }
}
