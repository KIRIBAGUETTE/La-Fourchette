//
//  RestaurantsListGest.swift
//  La Fourchette
//
//  Created by KIRIBAGUETTE on 01/05/2017.
//  Copyright © 2017 KIRIBAGUETTE. All rights reserved.
//

import Foundation

protocol RestaurantsListProtocol {
    func updateList()
    func deserialiseList()
    func stockList()
}

class RestaurantsList: RestaurantsListProtocol {
    
    let url:String = "https://api.lafourchette.com/api?key=IPHONEPRODEDCRFV&method=restaurant_get_info&id_restaurant=6861"
    
    // Deserialiser les informations du restaurant reçue de l'API
    
    func deserialiseList() {
        
    }
    
    // Stocker les informations du restaurant dans le CoreData
    
    func stockList() {
        
    }
    
    // Recupérer les informations du restaurant de l'API
    
    func updateList() {
        
    }
}
