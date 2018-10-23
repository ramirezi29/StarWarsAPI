//
//  DetailScreenExtension.swift
//  StarWarsAPI_iOS22
//
//  Created by Ivan Ramirez on 10/22/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import UIKit

extension StarWarsDetailTableViewController {
    
    func updateDetailUI() {
        updateDetailBackground()
    }
    
    
    func  updateDetailBackground() {
        
        let galaxyImage = UIImage(named: "galaxy")
        
        let imageView = UIImageView(image: galaxyImage)
        tableView.backgroundView = imageView
        imageView.contentMode = .scaleAspectFill
    }
}
