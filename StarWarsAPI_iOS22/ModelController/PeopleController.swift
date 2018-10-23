//
//  PeopleController.swift
//  StarWarsAPI_iOS22
//
//  Created by Ivan Ramirez on 10/22/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import Foundation

class PersonController {
    
    // NOTE: - No shared instance on this either
    
    static func fetCharacters(film: Film, completion: @escaping ([Person]?) -> Void) {
        
        var people: [Person] = []
        
        // NOTE: - If you want to wait for a task to complete before doing something
        //  All this stuff put it in a group, and once its done, will notify the Main Que and than call the completion
        let dispatchGroup = DispatchGroup()
        
        // NOTE: - Loop through the films
        for characherURL in film.characters {
            
            // Step: 1 - Constuct the URL. They gave us the end point already. easy peasy
            // NOTE: - Continue because we want the loop to conintue
            guard let url = URL(string: characherURL) else {completion(nil); return}
            
            // Step: 2 - Create URL Request - Skipped
            
            // NOTE: - This is the beginign of the task, i want you to put into the group
            dispatchGroup.enter()
            
            // Step: 3 - DataTask (using the URL) + Resume
            
            URLSession.shared.dataTask(with: url) { (data, _, error) in
                if let error = error {
                    print("\n\n🚀 There was an error with fetching the character in: \(#file) \n\n \(#function); \n\n\(error); \n\n\(error.localizedDescription) 🚀\n\n")
                    completion(nil)
                    return
                }
                
                guard let data = data else {
                    completion(nil)
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                
                do {
                    
                    let person = try jsonDecoder.decode(Person.self, from: data)
                    people.append(person)
                    
                }catch {
                    
                    print("\n\n🚀 There was an error with decoding the person data in: \(#file) \n\n \(#function); \n\n\(error); \n\n\(error.localizedDescription) 🚀\n\n")
                    completion(nil)
                }
                
                // NOTE: - This is a part that is done, that you can add to the group
                dispatchGroup.leave()
                }.resume()
        }
        // NOTE: -
        dispatchGroup.notify(queue: .main) {
            completion(people)
        }
    }
}
