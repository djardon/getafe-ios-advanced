//
//  UserDetailViewController.swift
//  CursoIOSAdvanced
//
//  Created by David Jardon on 17/10/2019.
//  Copyright © 2019 David Jardon. All rights reserved.
//

import UIKit


class UserDetailViewController: UIViewController {
    @IBOutlet weak var buttonDelete: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onActionPressed(_ sender: UIButton) {
        
    }
    
    
    private enum UserDetailCellType: Int {
        case personalData = 0
        case contact
        case location
        case map
    }
    
    var user: UserDetail? = nil
    private let cellTypes = [UserDetailCellType.personalData,
                             UserDetailCellType.map,
                             UserDetailCellType.contact,
                             UserDetailCellType.location]
    private var cellSpacing: CGFloat = 16.0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = user?.name
        configure(tableView: tableView)
    }
    
    private func edgesInsetsDistance(view: UIView) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0,
                            left: 0,
                            bottom: view.frame.size.height - (buttonDelete.frame.origin.y - view.frame.origin.y) + cellSpacing,
                            right: 0)
    }
}
 
extension UserDetailViewController: UITableViewDelegate, UITableViewDataSource {
    /// Configure tableView with default options
    func configure(tableView: UITableView) {
        tableView.register(UINib(nibName: UserDetailDataViewCell.cellIdentifier,
                                 bundle: nil),
                           forCellReuseIdentifier: UserDetailDataViewCell.cellIdentifier)
        tableView.register(UINib(nibName: UserDetailContactViewCell.cellIdentifier,
                                 bundle: nil),
                           forCellReuseIdentifier: UserDetailContactViewCell.cellIdentifier)
        tableView.register(UINib(nibName: UserDetailLocationViewCell.cellIdentifier,
                                 bundle: nil),
                           forCellReuseIdentifier: UserDetailLocationViewCell.cellIdentifier)
        tableView.register(UINib(nibName: UserDetailMapViewCell.cellIdentifier,
                                 bundle: nil),
                           forCellReuseIdentifier: UserDetailMapViewCell.cellIdentifier)
        
        tableView.contentInset = edgesInsetsDistance(view: tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight: CGFloat = 0
        
        switch cellTypes[indexPath.row] {
            case .personalData:
                cellHeight = UserDetailDataViewCell.cellHeight
                
            case .contact:
                cellHeight = UserDetailContactViewCell.cellHeight
                
            case .location:
                cellHeight = UserDetailLocationViewCell.cellHeight
                
            case .map:
                cellHeight = UserDetailMapViewCell.cellHeight
        }
        
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch cellTypes[indexPath.row] {
            case .personalData:
                cell = cellPersonalData(tableView: tableView,
                                        indexPath: indexPath)
                
            case .contact:
                cell = cellContact(tableView: tableView,
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserDetailDataViewCell.cellIdentifier,
                                                       for: indexPath) as? UserDetailDataViewCell else {
            return UITableViewCell()
        }
        
        // Configure cell data
        cell.configure(image: user?.avatar,
                       name: user?.firstName,
                       surname: user?.lastName,
                       gender: user?.gender,
                       birthdate: user?.birthdate,
                       age: user?.age)
        
        return cell
    }
    
    private func cellContact(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserDetailContactViewCell.cellIdentifier,
                                                       for: indexPath) as? UserDetailContactViewCell else {
            return UITableViewCell()
        }
        
        // Configure cell data
        cell.configure(email: user?.email,
                       cell: user?.cell,
                       mobile: user?.mobile)
        
        return cell
    }
    
    private func cellLocation(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserDetailLocationViewCell.cellIdentifier,
                                                       for: indexPath) as? UserDetailLocationViewCell else {
            return UITableViewCell()
        }
        
        // Configure cell data
        cell.configure(countryFlag: user?.countryFlag,
                       country: user?.country,
                       state: user?.state,
                       street: user?.street,
                       city: user?.city)
        
        return cell
    }
    
    private func cellMap(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserDetailMapViewCell.cellIdentifier,
                                                       for: indexPath) as? UserDetailMapViewCell else {
            return UITableViewCell()
        }
        
        // Configure cell data
        cell.configure(latitude: user?.latitude,
                       longitude: user?.longitude)
        
        return cell
    }
}

