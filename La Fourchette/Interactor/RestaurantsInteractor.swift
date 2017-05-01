//
//  RestaurantsListGest.swift
//  La Fourchette
//
//  Created by KIRIBAGUETTE on 01/05/2017.
//  Copyright © 2017 KIRIBAGUETTE. All rights reserved.
//

import Alamofire
import SwiftyJSON
import CoreData

protocol RestaurantsInteractorProtocol {
    func updateList()
    func deserialiseList(Json:JSON)
    func stockList(restaurant:RestaurantsEntity)
}

class RestaurantsInteractor: RestaurantsInteractorProtocol {
    
    // Liens vers l'interface Presenter
    
    var presenter:RestaurantsPresenter!
    
    let url:String = "https://api.lafourchette.com/api?key=IPHONEPRODEDCRFV&method=restaurant_get_info&id_restaurant=6861"
    
    // Deserialiser les informations du restaurant reçue de l'API
    
    func deserialiseList(Json:JSON) {
        print("DATAS : DESERIALISATION")
        if Json["result"].int == 1 {
            let restaurant:RestaurantsEntity = RestaurantsEntity()
            if let name = Json["data"]["name"].string {
                restaurant.name = name
            }
            if let address = Json["data"]["address"].string {
                restaurant.address = address
            }
            if let zipcode = Json["data"]["zipcode"].string {
                restaurant.zipcode = zipcode
            }
            if let city = Json["data"]["city"].string {
                restaurant.city = city
            }
            if let avg_rate = Json["data"]["avg_rate"].double {
                restaurant.avg_rate = avg_rate
            }
            if let gps_long = Json["data"]["gps_long"].double {
                restaurant.gps_long = gps_long
            }
            if let gps_lat = Json["data"]["gps_lat"].double {
                restaurant.gps_lat = gps_lat
            }
            if let rate_count = Json["data"]["rate_count"].int {
                restaurant.rate_count = rate_count
            }
            self.stockList(restaurant:restaurant)
        } else {
            self.presenter.errorRestaurantView(errorMessage: "Erreur API")
        }
    }
    
    // Stocker les informations du restaurant dans le CoreData
    
    func checkCoreData() {
        print("COREDATA : CHECK DATABSE")
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Restaurant")
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(request)
            if results.count != 0 {
                for result in results as! [NSManagedObject] {
                    print("COREDATA : DELETE DATABASE")
                    context.delete(result)
                }
                do {
                    try context.save()
                } catch {
                    self.presenter.errorRestaurantView(errorMessage: "Erreur CoreData")
                    print("Error")
                }
            }
        } catch {
            self.presenter.errorRestaurantView(errorMessage: "Erreur CoreData")
            print("ERROR")
        }
    }
    
    func stockList(restaurant:RestaurantsEntity) {
        print("DATAS : STOCK CORE DATA")
        self.checkCoreData()
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newRetaurant = NSEntityDescription.insertNewObject(forEntityName: "Restaurant", into: context)
        newRetaurant.setValue(restaurant.name, forKey: "name")
        newRetaurant.setValue(restaurant.address, forKey: "address")
        newRetaurant.setValue(restaurant.zipcode, forKey: "zipcode")
        newRetaurant.setValue(restaurant.city, forKey: "city")
        newRetaurant.setValue(restaurant.avg_rate, forKey: "avg_rate")
        newRetaurant.setValue(restaurant.gps_lat, forKey: "gps_lat")
        newRetaurant.setValue(restaurant.gps_long, forKey: "gps_long")
        newRetaurant.setValue(restaurant.rate_count, forKey: "rate_count")
        do {
            print("COREDATA : INSERT DATA")
            try context.save()
            self.presenter.updateRestaurantView()
        } catch {
            self.presenter.errorRestaurantView(errorMessage: "Erreur CoreData")
            print("Error during saving")
        }
        
    }
    
    // Recupérer les informations du restaurant de l'API
    
    func updateList() {
        print("DATAS : GET FROM API")
        Alamofire.request(url, method: .get).responseJSON { response in
            if response.result.isSuccess {
                if response.response?.statusCode == 200 {
                    self.deserialiseList(Json: JSON(response.result.value!))
                } else {
                    self.presenter.errorRestaurantView(errorMessage: "Erreur URL/API")
                }
            } else {
                
            }
        }
    }
}
