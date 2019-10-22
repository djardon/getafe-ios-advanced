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
    
    // MARK: - Properties
    var optionSelected: Int {
        return DatabaseManager.shared.optionSelected
    }
    
    private var usersDB: Array<UserDAO> {
        return Array(DatabaseManager.shared.users)
    }
    
    private var usersFromUsersDB: Array<User> {
        let usersDAO = usersDB
        // Convertir listado de UserDAO a listado de User
        return users(from: usersDAO)
    }
    
    
    // MARK: - Public methods
    func users(forceUpdate: Bool, completion: @escaping ServiceCompletion) {
        switch forceUpdate {
            case true:
                usersForceUpdate(completion: completion)

            case false:
                users(completion: completion)
        }
    }
    
    func user(by id: String, completion: @escaping ServiceCompletion) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            if let userDAO = DatabaseManager.shared.user(by: id) {
                let user = self?.user(from: userDAO)
                
                DispatchQueue.main.async {
                    completion(.success(data: user))
                }
            }
            else {
                DispatchQueue.main.async {
                    completion(.failure(msg: "No se ha encontrado el usuario"))
                }
            }
        }
    }
    
    func save(optionSelected: Int) {
        DatabaseManager.shared.save(option: optionSelected)
    }

    func userDetail(by id: String, completion: @escaping ServiceCompletion) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            if let userDAO = DatabaseManager.shared.user(by: id) {
                let userDetail = self?.userDetail(from: userDAO)
                
                DispatchQueue.main.async {
                    completion(.success(data: userDetail))
                }
            }
            else {
                DispatchQueue.main.async {
                    completion(.failure(msg: "No se ha encontrado el usuario"))
                }
            }
        }
    }
        
    // MARK: - Private methods
    private func users(completion: @escaping ServiceCompletion) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            if let users = self?.usersFromUsersDB, users.count > 0 {
                // devolver userDB
                DispatchQueue.main.async {
                    completion(.success(data: users))
                }
            }
            else {
                // llamar al servicio y guardar usuarios
                // en base de datos
                self?.usersForceUpdate(completion: completion)
            }
        }
    }
    
    private func usersForceUpdate(completion: @escaping ServiceCompletion) {
        // Llamar al servicio para obtener nuevos usuarios
        DispatchQueue.global(qos: .background).async {
            ApiManager.shared.fetchUsers() { [weak self] result in
                switch result {
                    case .success(let data):
                        guard let usersDTO = data as? UsersDTO else {
                            DispatchQueue.main.async {
                                completion(.failure(msg: "Mensaje error genérico"))
                            }
                            return
                        }
                        
                        // Eliminar todos los usuarios de la base de datos
                        DatabaseManager.shared.deleteAll()
                        // Guardar usuarios en la base de datos
                        self?.save(users: usersDTO)
                        // Cargar usuarios almacenados en la base de datos
                        let users = self?.usersFromUsersDB
                        
                        DispatchQueue.main.async {
                            completion(.success(data: users))
                        }
                    
                    case .failure(let msg):
                        print("Fallo al obtener usuarios del servicio: \(msg)")
                    
                        DispatchQueue.main.async {
                            completion(.failure(msg: msg))
                        }
                }
            }
        }
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
                             cell: user.cell,
                             mobile: user.phone,
                             gender: user.gender,
                             birthdate: user.dob?.date,
                             country: user.location?.country,
                             state: user.location?.state,
                             city: user.location?.city,
                             street: user.location?.street?.name,
                             nationality: user.nat,
                             latitude: user.location?.coordinates?.latitude,
                             longitude: user.location?.coordinates?.longitude)
        
        DatabaseManager.shared.save(user: userDB)
    }

    private func users(from usersDAO: Array<UserDAO>) -> Array<User> {
        return usersDAO.compactMap { userDAO in
            return self.user(from: userDAO)
        }
    }
    
    private func user(from userDAO: UserDAO) -> User {
        return User(id: userDAO.uuid,
                    avatar: userDAO.avatar,
                    firstName: userDAO.firstname,
                    lastName: userDAO.lastname,
                    email: userDAO.email,
                    birthdate: userDAO.birthdate)
    }
    
    private func userDetail(from userDAO: UserDAO) -> UserDetail {
        return UserDetail(id: userDAO.uuid,
                          avatar: userDAO.avatar,
                          firstName: userDAO.firstname,
                          lastName: userDAO.lastname,
                          gender: userDAO.gender,
                          birthdate: userDAO.birthdate,
                          email: userDAO.email,
                          cell: userDAO.cell,
                          mobile: userDAO.mobile,
                          country: userDAO.country,
                          state: userDAO.state,
                          city: userDAO.city,
                          street: userDAO.street,
                          nationality: userDAO.nationality,
                          latitude: userDAO.latitude,
                          longitude: userDAO.longitude)
    }
}
