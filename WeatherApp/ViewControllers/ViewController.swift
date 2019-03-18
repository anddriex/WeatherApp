//
//  ViewController.swift
//  WeatherApp
//
//  Created by andres on 3/13/19.
//  Copyright © 2019 tinkin. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftMoment

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var temperatureTextLabel: UILabel!
    @IBOutlet var weatherIconImageView: UIImageView!
    @IBOutlet weak var forecastTableView: UITableView!
    
    var locationManager: CLLocationManager?
    
    var forecastForNDays: [String:[WeatherForecast]] = [:]
    var todayForecast: [WeatherForecast] = []
    var firstDayForecast: [WeatherForecast] = []
    var secondDayForecast: [WeatherForecast] = []
    var thirdDayForecast: [WeatherForecast] = []
    var fourthDayForecast: [WeatherForecast] = []
    var fifthDayForecast: [WeatherForecast] = []
    
    var now = moment()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(now.format())
        locationManager = CLLocationManager()
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager?.requestWhenInUseAuthorization()
            locationManager?.startUpdatingLocation()
        }
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager?.startUpdatingLocation()
        }
        let latitude = Double(locationManager?.location?.coordinate.latitude ?? 0)
        let longitude = Double(locationManager?.location?.coordinate.longitude ?? 0)
        
        let networking = Networking()
        networking.getWeatherPropsByGeographicCoordinates(lat: latitude, lon: longitude) { (cityName, temperature, weatherIcon) in
            self.cityNameLabel.text = cityName
            self.temperatureTextLabel.text = String(format: "%.0f °C", temperature - 273.15)
                networking.getWeatherIcon(weatherIcon: weatherIcon) { (weatherIcon) in
                self.weatherIconImageView.image = weatherIcon
            }
        }
        networking.getForecastForFiveDays(lat: latitude, lon: longitude ) { (city, forecastList) in
            
            let currentDayForecast = moment().format("EEEE") // Sunday
            let firstDayForecast = moment().add(1, "d").format("EEEE")
            let secondDayForecast = moment().add(2, "d").format("EEEE")
            let thirdDayForecast = moment().add(3, "d").format("EEEE")
            let fourthDayForecast = moment().add(4, "d").format("EEEE")
            let fifthDayForecast = moment().add(5, "d").format("EEEE")
            
            for forecast in forecastList {
                let runningDayForecast = moment(forecast.date!).format("EEEE") // ..Sunday, ..Monday, ..Tuesday
                
                if runningDayForecast != currentDayForecast,
                    runningDayForecast == firstDayForecast {
                  self.firstDayForecast.append(forecast)
                    
                } else if runningDayForecast != currentDayForecast,
                    runningDayForecast == secondDayForecast {
                    self.secondDayForecast.append(forecast)
                } else if runningDayForecast != currentDayForecast,
                    runningDayForecast == thirdDayForecast {
                    self.thirdDayForecast.append(forecast)
                } else if runningDayForecast != currentDayForecast,
                    runningDayForecast == fourthDayForecast {
                    self.fourthDayForecast.append(forecast)
                }else if runningDayForecast != currentDayForecast,
                    runningDayForecast == fifthDayForecast {
                    self.fifthDayForecast.append(forecast)
                }else {
                    self.todayForecast.append(forecast)
                }
            }
            self.forecastForNDays.updateValue(self.firstDayForecast, forKey: firstDayForecast)
            self.forecastForNDays.updateValue(self.secondDayForecast, forKey: secondDayForecast)
            self.forecastForNDays.updateValue(self.thirdDayForecast, forKey: thirdDayForecast)
            self.forecastForNDays.updateValue(self.fourthDayForecast, forKey: fourthDayForecast)
            self.forecastForNDays.updateValue(self.fifthDayForecast, forKey: fifthDayForecast)
            
            self.forecastTableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return forecastForNDays.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var orderedKeys: [String] = []
        for k in forecastForNDays.keys {
            orderedKeys.append(k)
        }
        
        switch section {
        case 0:
            return forecastForNDays[orderedKeys[0]]?.count ?? 0
        case 1:
            return forecastForNDays[orderedKeys[1]]?.count ?? 0
        case 2:
            return forecastForNDays[orderedKeys[2]]?.count ?? 0
        case 3:
            return forecastForNDays[orderedKeys[3]]?.count ?? 0
        case 4:
            return forecastForNDays[orderedKeys[4]]?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var orderedKeys: [String] = []
        for k in forecastForNDays.keys {
            orderedKeys.append(k)
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "forecastCell") as! ForecastTableViewCell
        
        switch indexPath.section {
        case 0:
            cell.initFromWeatherForecast(weatherForecast: forecastForNDays[orderedKeys[0]]![indexPath.row])
            return cell
        case 1:
            cell.initFromWeatherForecast(weatherForecast: forecastForNDays[orderedKeys[1]]![indexPath.row])
            return cell
        case 2:
            cell.initFromWeatherForecast(weatherForecast: forecastForNDays[orderedKeys[2]]![indexPath.row])
            return cell
        case 3:
            cell.initFromWeatherForecast(weatherForecast: forecastForNDays[orderedKeys[3]]![indexPath.row])
            return cell
        case 4:
            cell.initFromWeatherForecast(weatherForecast: forecastForNDays[orderedKeys[4]]![indexPath.row])
            return cell
        default:
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var orderedKeys: [String] = []
        for k in forecastForNDays.keys {
            orderedKeys.append(k)
        }
        switch section {
        case 0:
            return orderedKeys[0]
        case 1:
            return orderedKeys[1]
        case 2:
            return orderedKeys[2]
        case 3:
            return orderedKeys[3]
        case 4:
            return orderedKeys[4]
        default:
            return "???"
        }
    }
}

