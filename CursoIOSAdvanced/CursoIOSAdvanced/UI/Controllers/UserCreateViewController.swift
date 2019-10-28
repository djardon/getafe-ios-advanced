//
//  UserCreateViewController.swift
//  CursoIOSAdvanced
//
//  Created by David Jardon on 28/10/2019.
//  Copyright © 2019 David Jardon. All rights reserved.
//

import UIKit


class UserCreateViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    private enum UserCreateCellType: Int {
        case personalData = 0
        case gender
        case contact
        case birthdate
        case country
        case location
        case map
    }
    
    private let cellTypes = [UserCreateCellType.personalData,
                             UserCreateCellType.gender,
                             UserCreateCellType.birthdate,
                             UserCreateCellType.contact,
                             UserCreateCellType.country,
                             UserCreateCellType.location,
                             UserCreateCellType.map]
    private var cellSpacing: CGFloat = 16.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure(tableView: tableView)
    }
}


extension UserCreateViewController: UITableViewDelegate, UITableViewDataSource {
    func configure(tableView: UITableView) {
        tableView.register(UINib(nibName: UserPersonalFieldsTableViewCell.cellIdentifier,
                                 bundle: nil),
                           forCellReuseIdentifier: UserPersonalFieldsTableViewCell.cellIdentifier)
        tableView.register(UINib(nibName: UserGenderFieldTableViewCell.cellIdentifier,
                                 bundle: nil),
                           forCellReuseIdentifier: UserGenderFieldTableViewCell.cellIdentifier)
        tableView.register(UINib(nibName: UserContactFieldsTableViewCell.cellIdentifier,
                                 bundle: nil),
                           forCellReuseIdentifier: UserContactFieldsTableViewCell.cellIdentifier)
        tableView.register(UINib(nibName: UserBirthdateTableViewCell.cellIdentifier,
                                 bundle: nil),
                           forCellReuseIdentifier: UserBirthdateTableViewCell.cellIdentifier)
        tableView.register(UINib(nibName: UserCountryFieldsTableViewCell.cellIdentifier,
                                 bundle: nil),
                           forCellReuseIdentifier: UserCountryFieldsTableViewCell.cellIdentifier)
        tableView.register(UINib(nibName: UserLocationFieldsTableViewCell.cellIdentifier,
                                 bundle: nil),
                           forCellReuseIdentifier: UserLocationFieldsTableViewCell.cellIdentifier)
        tableView.register(UINib(nibName: UserMapFieldsTableViewCell.cellIdentifier,
                                 bundle: nil),
                           forCellReuseIdentifier: UserMapFieldsTableViewCell.cellIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight: CGFloat = 0
        
        switch cellTypes[indexPath.row] {
            case .personalData:
                cellHeight = UserPersonalFieldsTableViewCell.cellHeight

            case .gender:
                cellHeight = UserGenderFieldTableViewCell.cellHeight
            
            case .contact:
                cellHeight = UserContactFieldsTableViewCell.cellHeight

            case .birthdate:
                cellHeight = UserBirthdateTableViewCell.cellHeight
            
            case .country:
                cellHeight = UserCountryFieldsTableViewCell.cellHeight
            
            case .location:
                cellHeight = UserLocationFieldsTableViewCell.cellHeight
                
            case .map:
                cellHeight = UserMapFieldsTableViewCell.cellHeight
        }
        
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch cellTypes[indexPath.row] {
            case .personalData:
                cell = cellPersonalData(tableView: tableView,
                                        indexPath: indexPath)

            case .gender:
                cellHeight = cellGender(tableView: tableView,
                                        indexPath: indexPath)
        
            case .contact:
                cell = cellContact(tableView: tableView,
                                   indexPath: indexPath)

            case .birthdate:
                cell = cellBirthdate(tableView: tableView,
                                     indexPath: indexPath)
            
            case .country:
                cell = cellCountry(tableView: tableView,
                                   indexPath: indexPath)
            
            case .location:
                cell = cellLocation(tableView: tableView,
                                    indexPath: indexPath)
                
            case .map:
                cell = cellMap(tableView: tableView,
                               indexPath: indexPath)
        }
        
        return cell
    }
    
    
    private func cellPersonalData(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserPersonalFieldsTableViewCell.cellIdentifier,
                                                       for: indexPath) as? UserPersonalFieldsTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    private func cellGender(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserGenderFieldTableViewCell.cellIdentifier,
                                                       for: indexPath) as? UserGenderFieldTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    private func cellContact(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserContactFieldsTableViewCell.cellIdentifier,
                                                       for: indexPath) as? UserContactFieldsTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    
    private func cellBirthdate(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserBirthdateTableViewCell.cellIdentifier,
                                                       for: indexPath) as? UserBirthdateTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    private func cellCountry(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCountryFieldsTableViewCell.cellIdentifier,
                                                       for: indexPath) as? UserCountryFieldsTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    private func cellLocation(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserLocationFieldsTableViewCell.cellIdentifier,
                                                       for: indexPath) as? UserLocationFieldsTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    private func cellMap(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserMapFieldsTableViewCell.cellIdentifier,
                                                       for: indexPath) as? UserMapFieldsTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}
