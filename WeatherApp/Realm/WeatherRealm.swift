//
//  WeatherRealm.swift
//  WeatherApp
//
//  Created by andres on 3/17/19.
//  Copyright © 2019 tinkin. All rights reserved.
//

import Foundation
import RealmSwift

class WeatherRealm: Object {
    @objc dynamic var id:Int = 0
    @objc dynamic var name:String = ""
    @objc dynamic var temp:Double = 0.0
    @objc dynamic var date:Double = 0.0
    @objc dynamic var main: String = ""
    
    convenience init(weatherMap: WeatherMap) {
        self.init()
        name = weatherMap.name!
        id = weatherMap.id!
        temp = weatherMap.temp!
        date = weatherMap.date!
        main = weatherMap.main!
    }
}
