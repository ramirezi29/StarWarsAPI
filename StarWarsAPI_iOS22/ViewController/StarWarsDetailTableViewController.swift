//
//  StarWarsDetailTableViewController.swift
//  StarWarsAPI_iOS22
//
//  Created by Ivan Ramirez on 10/22/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import UIKit

class StarWarsDetailTableViewController: UITableViewController {
    
    // NOTE: -  Source of truth
    var people: [Person] = []
    
    // NOTE: - Landing Pad
    var film: Film?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateDetailUI()
        
        // NOTE: - unwrap the film, bc the landing pad film were getting is an optional
        guard let film = film else {return}
        PersonController.fetCharacters(film: film) { (people) in
            
            // the, people is optional so we need to unwrapp
            guard let people = people else {return}
            
            // these are the peole that came back form the network call
            self.people = people
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    func updateViews() {
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath)
        
        let person = people[indexPath.row]
        
        cell.textLabel?.text = person.name
        cell.detailTextLabel?.text = "\(person.birthYear)"
        
        // Font and UI
        
        cell.textLabel?.textColor = UIColor(displayP3Red: 287/255, green: 236/255, blue: 11/255, alpha: 1.0)
        cell.textLabel?.font = UIFont(name: "Verdana-Bold", size: 20)
     
        
        
        cell.detailTextLabel?.textColor = UIColor(displayP3Red: 50/255, green: 236/255, blue: 29/255, alpha: 1.0)
        cell.detailTextLabel?.font = UIFont(name: "Verdana-Bold", size: 15)
     
        
        return cell
    }
    
   override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 0, alpha: 0)
    }
    
}
