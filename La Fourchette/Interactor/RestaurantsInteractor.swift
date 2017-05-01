//
//  RestaurantsListGest.swift
//  La Fourchette
//
//  Created by KIRIBAGUETTE on 01/05/2017.
//  Copyright © 2017 KIRIBAGUETTE. All rights reserved.
//

import Alamofire
import AlamofireImage
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
    
    let url:String = "https://api.lafourchette.com/api?key=IPHONEPRODEDCRFV&method=restaurant_get_info&id_restaurant=14163"
    
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
            if let picture_url = Json["data"]["pics_main"]["612x344"].string {
                self.entity.picture_url = picture_url
            }
            self.downloadTopPicture()
        } else {
            self.presenter.errorRestaurantView(errorMessage: "Erreur API")
        }
    }
    
    // Téléchargement de la photo à mettre en haut de page
    
    func downloadTopPicture() {
        Alamofire.request(self.entity.picture_url).responseImage { response in
            if response.response?.statusCode == 200 {
                self.entity.picture = response.result.value!
                self.stockList()
            } else {
                self.presenter.errorRestaurantView(errorMessage: "Erreur Download Image")
                print("Error")
            }
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
        let imageData = NSData(data: UIImageJPEGRepresentation(self.entity.picture, 1.0)!)
        newRetaurant.setValue(imageData, forKey: "picture")
        do {
            print("COREDATA : INSERT DATA")
            try context.save()
            self.presenter.updateRestaurantView()
        } catch {
            self.presenter.errorRestaurantView(errorMessage: "Erreur CoreData")
            print("Error during saving")
        }
        
    }
    
    // Mode OFFLINE
    
    func takeInformationFromCoreDate() {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Restaurant")
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(request)
            if results.count != 0 {
                for result in results as! [NSManagedObject] {
                    if let address = result.value(forKey: "address") as? String {
                        self.entity.address = address
                    }
                    if let name = result.value(forKey: "name") as? String {
                        self.entity.name = name
                    }
                    if let zipcode = result.value(forKey: "zipcode") as? String {
                        self.entity.zipcode = zipcode
                    }
                    if let city = result.value(forKey: "city") as? String {
                        self.entity.city = city
                    }
                    if let avg_rate = result.value(forKey: "avg_rate") as? Double {
                        self.entity.avg_rate = avg_rate
                    }
                    if let gps_lat = result.value(forKey: "gps_lat") as? Double {
                        self.entity.gps_lat = gps_lat
                    }
                    if let gps_long = result.value(forKey: "gps_long") as? Double {
                        self.entity.gps_long = gps_long
                    }
                    if let rate_count = result.value(forKey: "rate_count") as? Int {
                        self.entity.rate_count = rate_count
                    }
                    if let picture = result.value(forKey: "picture") as? Data {
                        self.entity.picture = (UIImage(data:picture))!
                    }
                }
                self.presenter.updateRestaurantView()
            } else {
                print("No Data No Network")
                self.presenter.errorRestaurantView(errorMessage: "No Data And No Network")
            }
        } catch {
            print("No Data No Network")
            self.presenter.errorRestaurantView(errorMessage: "No Data And No Network")
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
                print("ici")
                self.takeInformationFromCoreDate()
            }
        }
    }
}
