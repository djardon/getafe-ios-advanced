//
//  InfoDTO.swift
//  CursoIOSAdvanced
//
//  Created by David Jardon on 04/10/2019.
//  Copyright © 2019 David Jardon. All rights reserved.
//

import Foundation

struct InfoDTO: Codable {
    let seed: String?
    let page: Int?
    let version: String?
    let count: Int?
    
    private enum CodingKeys: String, CodingKey {
        case seed
        case page
        case version
        case count = "results"
    }
}
