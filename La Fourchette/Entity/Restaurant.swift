//
//  Restaurant.swift
//  La Fourchette
//
//  Created by KIRIBAGUETTE on 01/05/2017.
//  Copyright © 2017 KIRIBAGUETTE. All rights reserved.
//

import Foundation

class Restaurant {
    var name:String
    var street:String
    var zipcode:String
    var city:String
    var avg_rate:Double
    var gps_lat:Double
    var gps_long:Double
    var rate_count:Int
    
    init(name:String,
         street:String,
         zipcode:String,
         city:String,
         avg_rate:Double,
         gps_lat:Double,
         gps_long:Double,
         rate_count:Int) {
        self.name = name
        self.street = street
        self.zipcode = zipcode
        self.city = city
        self.avg_rate = avg_rate
        self.gps_lat = gps_lat
        self.gps_long = gps_long
        self.rate_count = rate_count
    }
}
