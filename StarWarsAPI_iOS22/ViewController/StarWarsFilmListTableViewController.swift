//
//  StarWarsFilmListTableViewController.swift
//  StarWarsAPI_iOS22
//
//  Created by Ivan Ramirez on 10/22/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import UIKit

class StarWarsFilmListTableViewController: UITableViewController {
    
    // NOTE: - We need a Source of Trueth  put this inorder for every one in the scop of this class (StarWarsFilmListTableViewController) in order for them to call upon it 
    var films: [Film] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
        FilmController.fetchAllFilms { (films) in
            guard let films = films else {return}
            // NOTE: - Now that films that came back are part of the Source of Truth array 
            self.films = films
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return films.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath)
        let film = films[indexPath.row]
        
        cell.textLabel?.text = film.title
        cell.detailTextLabel?.text = (" Episode ID: \(film.episodeID)")
        
        // NOTE: - Font
        //text Label
        cell.textLabel?.textColor = UIColor(displayP3Red: 287/255, green: 236/255, blue: 11/255, alpha: 1.0)
        cell.textLabel?.font = UIFont(name: "Verdana-Bold", size: 20)
        
        cell.detailTextLabel?.textColor = UIColor(displayP3Red: 50/255, green: 236/255, blue: 29/255, alpha: 1.0)
        cell.detailTextLabel?.font = UIFont(name: "Verdana-Bold", size: 15)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 0, alpha: 0)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            // NOTE: - Finding out where were going
            guard let distinationVC = segue.destination as? StarWarsDetailTableViewController,
                
                // NOTE: - give me the cell the user tapped on
                let indexPath = tableView.indexPathForSelectedRow
                else {return}
            
            let film = films[indexPath.row]
            distinationVC.film = film
        }
    }
}


