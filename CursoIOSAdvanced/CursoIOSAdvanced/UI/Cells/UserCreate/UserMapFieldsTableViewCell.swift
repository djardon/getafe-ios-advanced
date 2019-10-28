//
//  UserMapFieldsTableViewCell.swift
//  CursoIOSAdvanced
//
//  Created by David Jardon on 28/10/2019.
//  Copyright © 2019 David Jardon. All rights reserved.
//

import UIKit
import MapKit

class UserMapFieldsTableViewCell: UITableViewCell {
    static let cellIdentifier = String(describing: UserMapFieldsTableViewCell.self)
    static let cellHeight: CGFloat = 300

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var fieldLatitude: UITextField!
    @IBOutlet weak var fieldLongitude: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
