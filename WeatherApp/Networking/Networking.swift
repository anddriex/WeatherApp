//
//  Networking.swift
//  WeatherApp
//
//  Created by andres on 3/13/19.
//  Copyright © 2019 tinkin. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import AlamofireImage

class Networking {
    let apikey = "6a4439cf7d6a24c18b0add4dc8ee887d"
    typealias JSONStandar = Dictionary<String, AnyObject>
    
    func getWeatherPropsByGeographicCoordinates(lat: Double, lon: Double, onCompletion:@escaping (String, Double, String) -> ()) {
        Alamofire.request("https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&APPID=\(apikey)").responseObject {(response:DataResponse<WeatherMap>) in
            switch response.result {
            case .success:
                var cityName = "???"
                var temperature = 0.0
                var weatherIcon = "???"
                
                if  let nameResult = response.result.value!.name,
                    let temperatureResult = response.result.value!.temp,
                    let weatherIconResult = response.result.value!.weatherIcon {
                    weatherIcon = weatherIconResult
                    cityName = nameResult
                    temperature = temperatureResult
                }
                onCompletion(cityName, Double(temperature), weatherIcon)
            case .failure:
                print("error")
            }
        }
    }
    
    func getForecastForFiveDays(lat: Double, lon: Double, onCompletion:@escaping (String, [WeatherForecast]) -> ()) {
        Alamofire.request("https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&APPID=\(apikey)").responseObject {(respone:DataResponse<WeatherMapList>) in
            switch respone.result {
            case .success:
                let weatherMapList = respone.result.value
                var city: String?
                var forecastList: [WeatherForecast] = []
                
                if let forecastForCity = weatherMapList?.city,
                    let fiveDayForecast = weatherMapList?.forecast {
                      city = forecastForCity
                    for forecast in fiveDayForecast {
                        forecastList += [forecast]
                    }
                }
                
                onCompletion(city!, forecastList)
            case .failure:
                print("error")
            }
        }
    }
    func getWeatherIcon(weatherIcon: String, onCompletion:@escaping (UIImage) -> ()) {
        Alamofire.request("https://openweathermap.org/img/w/\(weatherIcon).png").responseImage
            { (response) in
                switch response.result {
                case .success:
                    onCompletion(response.result.value!)
                case .failure:
                    print("error getting weather icon")
                }
        }
    }
    func getWeatherByCityName(cityName: String, onCompletion:@escaping (Double, String, WeatherMap) -> ()) {
        Alamofire.request("https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&APPID=\(apikey)").responseObject { (response: DataResponse<WeatherMap>) in
            switch response.result {
            case .success:
                var temperature = 0.0
                var iconId = "???"
                if let temperatureResult = response.result.value!.temp,
                    let iconIdResult = response.result.value!.weatherIcon{
                    iconId = iconIdResult
                    temperature = temperatureResult
                }
                onCompletion(Double(temperature), iconId, response.result.value!)
                
            case .failure:
                print("Error getting weather by city name")
            }
        }
    }
}
