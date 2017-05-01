//
//  Restaurant.swift
//  La Fourchette
//
//  Created by KIRIBAGUETTE on 01/05/2017.
//  Copyright © 2017 KIRIBAGUETTE. All rights reserved.
//

import UIKit

class RestaurantsEntity {
    var name:String
    var address:String
    var zipcode:String
    var city:String
    var avg_rate:Double
    var gps_lat:Double
    var gps_long:Double
    var rate_count:Int
    var picture_url:String
    var picture:UIImage
    
    init(name:String,
         address:String,
         zipcode:String,
         city:String,
         avg_rate:Double,
         gps_lat:Double,
         gps_long:Double,
         rate_count:Int,
         picture_url:String,
         picture:UIImage) {
        self.name = name
        self.address = address
        self.zipcode = zipcode
        self.city = city
        self.avg_rate = avg_rate
        self.gps_lat = gps_lat
        self.gps_long = gps_long
        self.rate_count = rate_count
        self.picture_url = picture_url
        self.picture = picture
    }
    
    init() {
        self.name = ""
        self.address = ""
        self.zipcode = ""
        self.city = ""
        self.avg_rate = 0
        self.gps_lat = 0
        self.gps_long = 0
        self.rate_count = 0
        self.picture_url = ""
        self.picture = UIImage()
    }
}
