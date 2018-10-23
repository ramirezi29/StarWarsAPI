//
//  PersonModel.swift
//  StarWarsAPI_iOS22
//
//  Created by Ivan Ramirez on 10/22/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import Foundation

struct Person: Decodable {
    
    let name: String
    let birthYear: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case birthYear = "birth_year"
    }
}
