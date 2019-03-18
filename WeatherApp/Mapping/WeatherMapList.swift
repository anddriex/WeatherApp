//
//  WeatherMapList.swift
//  WeatherApp
//
//  Created by andres on 3/16/19.
//  Copyright © 2019 tinkin. All rights reserved.
//

import Foundation
import ObjectMapper

class WeatherMapList: Mappable {
    var city: String?
    var forecast: [WeatherForecast]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        city <- map["city.name"]
        forecast <- map["list"]
    }
}
class WeatherForecast: Mappable {
    var description: String?
    var date: Double?
    var temperature: Double?
    var iconId: String?
    var dateText: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        description <- map["weather.0.description"]
        date <- map["dt"]
        temperature <- map["main.temp"]
        iconId <- map["weather.0.icon"]
        dateText <- map["dt_txt"]
    }
    
}
