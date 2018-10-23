//
//  FilmController.swift
//  StarWarsAPI_iOS22
//
//  Created by Ivan Ramirez on 10/22/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import Foundation

class FilmController {
    
    // NOTE: - No shared instance on this either
    
    static let baseURL = URL(string: "https://swapi.co/api/")
    
    // NOTE: - Doest have searTerm: String in the parameters bc we are not including a searchBar we are just getting back all the films
    static func fetchAllFilms(completion: @escaping ([Film]?) -> Void ) {
        
        // Step: 1 - Construct base URL
        
        guard var url = baseURL else {completion(nil); return}
        
        // AppendING returns a brand new URL, here we use just want to mutate the base URL
        // https://swapi.co/api/films/
        url.appendPathComponent("films")
        print(url.absoluteURL)
        
        // Step: 2 - Create the URL Request, in this project it is not required. But we are going to put it for practice, and bc we have a request our DataTask needs the one that has the "Request"
        
        var request = URLRequest(url: url)
        request.httpBody = nil
        request.httpMethod = "GET"
        
        // Step: 3 - Data Task + Resume
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("\n\n🚀 There was an error with retrieing the films in: \(#file) \n\n(#function); \n\n\(error); \n\n\(error.localizedDescription) 🚀\n\n")
                completion(nil)
                return
            }
            
            // NOTE: - 'data' right now is the top level
            guard let data = data else {
                completion (nil)
                return
            }
            
            // NOTE: - At this point we got back EVERYTHING and we need to decode through it and get what we want
            let jsonDecoder = JSONDecoder()
            
            // NOTE: - Safetly Decode, we're going to need a do/Try/catch block
            do {
                
                // jsonDecoder.decode(T##type: Decodable.Protocol##Decodable.Protocol -> its a top level
                let topLevelObject = try jsonDecoder.decode(TopLevelObject.self, from: data)
                let filmsWeGotFromTheWeb = topLevelObject.results
                
                // NOTE: - We successfully completed
                completion(filmsWeGotFromTheWeb)
                
            } catch {
                print("\n\n🚀 There was an error with decoding the fillms in: \(#file) \n\n(#function); \n\n\(error); \n\n\(error.localizedDescription) 🚀\n\n")
                completion(nil)
                return
            }
            
            }.resume()
        
        
    }
    
}// last
