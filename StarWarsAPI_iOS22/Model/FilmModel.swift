//
//  FilmModel.swift
//  StarWarsAPI_iOS22
//
//  Created by Ivan Ramirez on 10/22/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import Foundation

struct TopLevelObject: Decodable {
    
    // NOTE: - we have to start withthe first Node
    // in the JSon we care about the "Results"
    let results: [Film]
}

struct Film: Decodable {
    
    let title: String
    let episodeID: Int
    let characters: [String]
    
    enum CodingKeys: String, CodingKey {
        case title
        case episodeID = "episode_id"
        case characters
    }
    
}

