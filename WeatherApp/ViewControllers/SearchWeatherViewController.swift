//
//  SearchWeatherViewController.swift
//  WeatherApp
//
//  Created by andres on 3/17/19.
//  Copyright © 2019 tinkin. All rights reserved.
//

import UIKit
import RealmSwift

class SearchWeatherViewController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate, UIPickerViewDataSource {
    
    
    var cities = ["London", "Paris", "Quito"]
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var citypPickerView: UIPickerView!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        citypPickerView.delegate = self
        citypPickerView.dataSource  = self
        updateWeather()
//        let weatherRealm = WeatherRealm(weatherMap: WeatherMap())
//        do {
//            let realm = try Realm()
//            try realm.write {
//                realm.add(weatherRealm)
//                NotificationCenter.default.post(name: Notification.Name("WeatherMapNotification"), object: nil, userInfo:["weather": weatherRealm])
//            }
//        } catch {}
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goButtonPressed(_ sender: Any) {
        updateWeather()
    }
    
    func updateWeather() {
        let networking = Networking()
        networking.getWeatherByCityName(cityName: cityTextField.text ?? "Quito") { (temperature, iconId, weatherMap) in
            self.temperatureLabel.text = String(format: "%.0f °C", temperature - 273.15)
            networking.getWeatherIcon(weatherIcon: iconId) { (weatherIcon) in
                self.weatherIconImageView.image = weatherIcon
            }
        }
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        citypPickerView.isHidden = false
        return false
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cityTextField.text = cities[row]
    }
    
    func addCity(city: String ) {
        cities.append(city)
    }
}
