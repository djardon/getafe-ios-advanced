//
//  DataManager.swift
//  CursoIOSAdvanced
//
//  Created by David Jardon on 04/10/2019.
//  Copyright © 2019 David Jardon. All rights reserved.
//

import Foundation

class DataManager {
    // MARK: - Singleton declaration
    static let shared = DataManager()
    private init() {}
    
    
    func users(completion: ServiceCompletion) {
        let users = usersDB()
        if users.count > 0 {
            // devolver userDB
            completion(.success(data: users))
        }
        else {
            // llamar al servicio y guardar usuarios
            // en base de datos
            usersForceUpdate(completion: completion)
        }
    }
    
    func usersForceUpdate(completion: ServiceCompletion) {
        // Llamar al servicio para obtener nuevos usuarios
        ApiManager.shared.fetchUsers() { result in
            switch result {
                case .success(let data):
                    guard let users = data as? UsersDTO else {
                        completion(.failure(msg: "Mensaje error genérico"))
                        return
                    }
                    
                    // Eliminar todos los usuarios de la base de datos
                    DatabaseManager.shared.deleteAll()
                    // Guardar usuarios en la base de datos
                    save(users: users)
                    completion(.success(data: users))
                
                case .failure(let msg):
                    print("Fallo al obtener usuarios del servicio: \(msg)")
                    completion(.failure(msg: msg))
            }
        }
    }
    
    func user(by id: String) -> UserDAO? {
        return DatabaseManager.shared.user(by: id)
    }
    
    
    private func usersDB() -> Array<UserDAO> {
        return Array(DatabaseManager.shared.users())
    }
    
    private func save(users: UsersDTO) {
        guard let usersToSave = users.users else {
            return
        }
        
        usersToSave.forEach{ save(user: $0) }
    }
    
    private func save(user: UserDTO) {
        guard let userId = user.login?.uuid else {
            return
        }
        
        let userDB = UserDAO(uuid: userId,
                             avatar: user.picture?.large,
                             firstname: user.name?.first,
                             lastname: user.name?.last,
                             email: user.email,
                             gender: user.gender,
                             birthdate: user.dob?.date,
                             country: user.location?.country,
                             latitude: user.location?.coordinates?.latitude,
                             longitude: user.location?.coordinates?.longitude)
        
        DatabaseManager.shared.save(user: userDB)
    }
}
