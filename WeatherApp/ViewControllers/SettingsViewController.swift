//
//  SettingsViewController.swift
//  WeatherApp
//
//  Created by andres on 3/17/19.
//  Copyright © 2019 tinkin. All rights reserved.
//

import UIKit

protocol AddCityDelegate {
    func addCity(city: String)
}
class SettingsViewController: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    var delegate: AddCityDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func addCityButtonPressed(_ sender: Any) {
        if cityTextField.text != "" {
            delegate?.addCity(city: cityTextField.text!)
            dismiss(animated: true, completion: nil)
        }else {
            let alert = UIAlertController(title: "Error", message: "Please select a city", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
}
