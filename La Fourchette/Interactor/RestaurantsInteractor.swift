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
    func stockList()
}

class RestaurantsInteractor: RestaurantsInteractorProtocol {
    
    // Lien vers l'interface Presenter
    
    var presenter:RestaurantsPresenter!
    
    // Lien vers l'interface Entity
    
    var entity:RestaurantsEntity!
    
    let url:String = "https://api.lafourchette.com/api?key=IPHONEPRODEDCRFV&method=restaurant_get_info&id_restaurant=6861"
    
    // Deserialiser les informations du restaurant reçue de l'API
    
    func deserialiseList(Json:JSON) {
        print("DATAS : DESERIALISATION")
        if Json["result"].int == 1 {
            if let name = Json["data"]["name"].string {
                self.entity.name = name
            }
            if let address = Json["data"]["address"].string {
                self.entity.address = address
            }
            if let zipcode = Json["data"]["zipcode"].string {
                self.entity.zipcode = zipcode
            }
            if let city = Json["data"]["city"].string {
                self.entity.city = city
            }
            if let avg_rate = Json["data"]["avg_rate"].double {
                self.entity.avg_rate = avg_rate
            }
            if let gps_long = Json["data"]["gps_long"].double {
                self.entity.gps_long = gps_long
            }
            if let gps_lat = Json["data"]["gps_lat"].double {
                self.entity.gps_lat = gps_lat
            }
            if let rate_count = Json["data"]["rate_count"].int {
                self.entity.rate_count = rate_count
            }
            self.stockList()
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
    
    func stockList() {
        print("DATAS : STOCK CORE DATA")
        self.checkCoreData()
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newRetaurant = NSEntityDescription.insertNewObject(forEntityName: "Restaurant", into: context)
        newRetaurant.setValue(self.entity.name, forKey: "name")
        newRetaurant.setValue(self.entity.address, forKey: "address")
        newRetaurant.setValue(self.entity.zipcode, forKey: "zipcode")
        newRetaurant.setValue(self.entity.city, forKey: "city")
        newRetaurant.setValue(self.entity.avg_rate, forKey: "avg_rate")
        newRetaurant.setValue(self.entity.gps_lat, forKey: "gps_lat")
        newRetaurant.setValue(self.entity.gps_long, forKey: "gps_long")
        newRetaurant.setValue(self.entity.rate_count, forKey: "rate_count")
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
