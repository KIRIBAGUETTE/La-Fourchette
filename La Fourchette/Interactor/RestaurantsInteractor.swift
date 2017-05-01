//
//  RestaurantsListGest.swift
//  La Fourchette
//
//  Created by KIRIBAGUETTE on 01/05/2017.
//  Copyright © 2017 KIRIBAGUETTE. All rights reserved.
//

import Alamofire
import SwiftyJSON

protocol RestaurantsInteractorProtocol {
    func updateList()
    func deserialiseList(Json:JSON)
    func stockList()
}

class RestaurantsInteractor: RestaurantsInteractorProtocol {
    
    // Liens vers l'interface Presenter
    
    var presenter:RestaurantsPresenter!
    
    let url:String = "https://api.lafourchette.com/api?key=IPHONEPRODEDCRFV&method=restaurant_get_info&id_restaurant=6861"
    
    // Deserialiser les informations du restaurant reçue de l'API
    
    func deserialiseList(Json:JSON) {
        print(Json)
    }
    
    // Stocker les informations du restaurant dans le CoreData
    
    func stockList() {
        
    }
    
    // Recupérer les informations du restaurant de l'API
    
    func updateList() {
        Alamofire.request(url, method: .get).responseJSON { response in
            if response.result.isSuccess {
                if response.response?.statusCode == 200 {
                    self.deserialiseList(Json: JSON(response.result.value!))
                }
            }
        }
    }
}
