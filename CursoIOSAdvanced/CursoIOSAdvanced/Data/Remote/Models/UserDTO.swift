//
//  UserDTO.swift
//  CursoIOSAdvanced
//
//  Created by David Jardon on 04/10/2019.
//  Copyright © 2019 David Jardon. All rights reserved.
//

import Foundation

struct UserDTO: Codable {
    let gender: String?
    let name: NameDTO?
    let email: String?
    let dob: DobDTO?
    let registered: DobDTO?
    let phone: String?
    let cell: String?
    let picture: PictureDTO?
    let nat: String?
    let location: LocationDTO?

    // Hide because service return some
    // errors with this data
    let id: IdDTO?
    let login: LoginDTO?
}
