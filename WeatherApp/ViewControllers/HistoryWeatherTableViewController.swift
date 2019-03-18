//
//  HistoryWeatherTableViewController.swift
//  WeatherApp
//
//  Created by andres on 3/17/19.
//  Copyright © 2019 tinkin. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftMoment

class HistoryWeatherTableViewController: UITableViewController {
    var weather: [WeatherRealm] = []
    
    @IBOutlet var historyTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyTableView.tableFooterView = UIView()
        NotificationCenter.default.addObserver(self, selector: #selector(newWeatherMap), name: Notification.Name("WeatherMapNotification"), object: nil)
        do {
            let realm = try Realm()
            weather = Array<WeatherRealm>(realm.objects(WeatherRealm.self))
        } catch {}
    }
    
    @objc func newWeatherMap(notification: Notification) {
        let userInfo = notification.userInfo
        let newWeather = userInfo!["weather"] as! WeatherRealm
        weather += [newWeather]
        tableView.insertRows(at: [IndexPath(row: weather.count - 1, section: 0)], with: .automatic)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath)
        let date = moment(weather[indexPath.row].date).format("EEE, dd MM HH:mm")
        let city = weather[indexPath.row].name
        let temp = weather[indexPath.row].temp
        let main = weather[indexPath.row].main
        cell.textLabel?.text = "\(city) \(date) \(temp) \(main)"
        return cell
    }
}
