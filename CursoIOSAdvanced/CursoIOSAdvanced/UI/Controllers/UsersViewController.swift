//
//  UsersViewController.swift
//  CursoIOSAdvanced
//
//  Created by David Jardon on 03/10/2019.
//  Copyright © 2019 David Jardon. All rights reserved.
//

import UIKit


class UsersViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentOptions: UISegmentedControl!
    
    // Value changed
    @IBAction func onListTypePressed(_ sender: UISegmentedControl) {
        // Save selected option
        DataManager.shared.save(optionSelected: sender.selectedSegmentIndex)
        // Update selected list type view
        updateListType(optionSelected: sender.selectedSegmentIndex)
    }
    
    // MARK: - Properties
    private let segueToDetail = "SegueMainToDetail"
    private var cellSpacing: CGFloat = 16.0
    private var users: Array<User> = []
    
    private let refreshControlTableView = UIRefreshControl()
    private let refreshControlCollectionView = UIRefreshControl()

    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureRefreshControl()
        
        configure(tableView: tableView)
        configure(collectionView: collectionView)
        
        loadOptionSelected()
        loadUsers()
    }
    
    private func configureRefreshControl() {
        // Configure Refresh Control
        refreshControlTableView.addTarget(self,
                                          action: #selector(refreshUsers),
                                          for: .valueChanged)
        refreshControlCollectionView.addTarget(self,
                                               action: #selector(refreshUsers),
                                               for: .valueChanged)
    }
    
    private func loadOptionSelected() {
        segmentOptions.selectedSegmentIndex = DataManager.shared.optionSelected
    }
    
    private func loadUsers() {
        DataManager.shared.users(forceUpdate: false) { [weak self] result in
            self?.parseUsers(result: result)
        }
    }
    
    @objc private func refreshUsers() {
        DataManager.shared.users(forceUpdate: true) { [weak self] result in
            self?.parseUsers(result: result)
        }
    }
    
    private func parseUsers(result: ServiceResult) {
        switch result {
            case .success(let data):
                guard let users = data as? Array<User> else {
                    return
                }
            
                self.users = users
                updateListType(optionSelected:
                segmentOptions.selectedSegmentIndex)
                
            case .failure(let msg):
                print(msg)
        }

        refreshControlTableView.endRefreshing()
        refreshControlCollectionView.endRefreshing()
    }
    
    private func updateListType(optionSelected: Int?) {
        switch optionSelected {
            case 0:
                tableView.isHidden = false
                collectionView.isHidden = true
                tableView.reloadData()
                
            default:
                tableView.isHidden = true
                collectionView.isHidden = false
                collectionView.reloadData()
        }
    }
    
    private func edgesInsetsDistance(view: UIView) -> UIEdgeInsets {
        return UIEdgeInsets(top: (segmentOptions.frame.origin.y - view.frame.origin.y) + segmentOptions.frame.size.height + cellSpacing,
                            left: 0,
                            bottom: 0,
                            right: 0)
    }
}


// MARK: - Extension TableView methods
extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    /// Configure tableView with default options
    func configure(tableView: UITableView) {
        tableView.register(UINib(nibName: PersonTableViewCell.cellIdentifier,
                                 bundle: nil),
                           forCellReuseIdentifier: PersonTableViewCell.cellIdentifier)
       
        tableView.contentInset = edgesInsetsDistance(view: tableView)
        tableView.refreshControl = refreshControlTableView
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.cellIdentifier,
                                                       for: indexPath) as? PersonTableViewCell else {
            return UITableViewCell()
        }
        
        if (indexPath.row < users.count) {
            let user = users[indexPath.row]
            cell.configureCell(image: user.avatar,
                               name: user.name,
                               email: user.email,
                               birthdate: user.birthdate)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigate(to: indexPath)
    }
}


// MARK: - Extension CollectionView methods
extension UsersViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    /// Configure collectionView with default options
    func configure(collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: PersonCollectionViewCell.cellIdentifier,
                                      bundle: nil),
                                forCellWithReuseIdentifier: PersonCollectionViewCell.cellIdentifier)
        
        collectionView.contentInset = edgesInsetsDistance(view: collectionView)
        collectionView.refreshControl = refreshControlCollectionView
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCollectionViewCell.cellIdentifier,
                                                       for: indexPath) as? PersonCollectionViewCell else {
            return UICollectionViewCell()
        }

        if (indexPath.row < users.count) {
            let user = users[indexPath.row]
            cell.configureCell(image: user.avatar,
                               title: user.name)
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = (collectionView.frame.size.width - cellSpacing) / 2
        return CGSize(width: size,
                      height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigate(to: indexPath)
    }
}

// MARK: - Navigation
extension UsersViewController {
    
    private func navigate(to indexPath: IndexPath) {
        let user = users[indexPath.row]
        
        DataManager.shared.userDetail(by: user.id) { [weak self] result in
            switch result {
                case .success(let data):
                    guard let userDetail = data as? UserDetail,
                          let segueIdentifier = self?.segueToDetail else {
                        return
                    }

                    self?.performSegue(withIdentifier: segueIdentifier,
                                       sender: userDetail)
                
                case .failure(let msg):
                    print(msg)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? UserDetailViewController,
              let userDetail = sender as? UserDetail else {
            return
        }
        
        destination.user = userDetail
    }
}
