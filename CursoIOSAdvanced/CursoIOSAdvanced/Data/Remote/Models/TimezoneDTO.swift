//
//  TimezoneDTO.swift
//  CursoIOSAdvanced
//
//  Created by David Jardon on 04/10/2019.
//  Copyright © 2019 David Jardon. All rights reserved.
//

import Foundation

struct TimezoneDTO: Codable {
    let offset: String?
    let info: String?
    
    
    private enum CodingKeys: String, CodingKey {
        case info = "description"
        case offset
    }
}
