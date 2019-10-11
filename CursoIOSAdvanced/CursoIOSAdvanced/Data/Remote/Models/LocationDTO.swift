//
//  LocationDTO.swift
//  CursoIOSAdvanced
//
//  Created by David Jardon on 04/10/2019.
//  Copyright © 2019 David Jardon. All rights reserved.
//

import Foundation

struct LocationDTO: Codable {
    let city: String?
    let state: String?
    let coordinates: CoordinatesDTO?
    
    let street: StreetDTO?
    let country: String?
    let timezone: TimezoneDTO?
    // Service Error
    //let postcode: Int?
}
