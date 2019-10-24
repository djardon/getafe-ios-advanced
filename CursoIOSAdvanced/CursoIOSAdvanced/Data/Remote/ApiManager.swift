//
//  ApiManager.swift
//  CursoIOSAdvanced
//
//  Created by David Jardon on 07/10/2019.
//  Copyright © 2019 David Jardon. All rights reserved.
//

import Foundation
import Alamofire


enum ServiceResult {
    case success(data: Any?)
    case failure(msg: String)
}

typealias ServiceCompletion = (_ results: ServiceResult) -> ()


class ApiManager {
    // MARK: - Singleton declaration
    static let shared = ApiManager()
    private init() {}
    
    // Properties
    private let url_users = "https://randomuser.me/api/"
    private let serviceKeyResults = "results"
    private let serviceResultsCount = 50
    private let serviceResultDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    

    private var testLoadUsersJson: UsersDTO? {
        if let path = Bundle.main.path(forResource: "users", ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
                
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = serviceResultDateFormat
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                return try decoder.decode(UsersDTO.self, from: jsonData)
            }
            catch let error {
                print("parse error: \(error.localizedDescription)")
                return nil
            }
        }
        else {
            print("Invalid filename/path.")
            return nil
        }
    }
    
    func fetchUsers(completion: @escaping ServiceCompletion) {
        // Llamar al servicio
        Alamofire.request(url_users,
                          method: .get,
                          parameters: [serviceKeyResults: serviceResultsCount],
                          encoding: URLEncoding.queryString).response { [weak self] response in
            if let responseData = response.data {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = self?.serviceResultDateFormat
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                let users: UsersDTO? = try? decoder.decode(UsersDTO.self, from: responseData)
                let usersOrdered = users?.users
                //?.sorted(by: { $0.dob?.age ?? 0 < $1.dob?.age ?? 0 })
                
                completion(.success(data: UsersDTO(users: usersOrdered,
                                                   info: users?.info)))
            }
            else {
                completion(.failure(msg: "Error en petición al servicio"))
            }
        }
    }
}
