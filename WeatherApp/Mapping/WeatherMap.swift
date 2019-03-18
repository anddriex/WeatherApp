//
//  WeatherMap.swift
//  WeatherApp
//
//  Created by andres on 3/13/19.
//  Copyright © 2019 tinkin. All rights reserved.
//

import Foundation
import ObjectMapper

class WeatherMap: Mappable {
    var id: Int?
    var name: String?
    var temp: Double?
    var weatherIcon: String?
    var date: Double?
    var main: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        temp <- map["main.temp"]
        weatherIcon <- map["weather.0.icon"]
        date <- map["dt"]
        main <- map["weather.0.main"]
    }
}

