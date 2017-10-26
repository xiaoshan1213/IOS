//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate, DataInterface {
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "514b2ede8a5fd2fe940cc286d7cca323"
//    http://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=514b2ede8a5fd2fe940cc286d7cca323
    
    

    //TODO: Declare instance variables here
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()

    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //TODO:Set up the location manager here.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    func getWeatherData(parameters : Parameters){
        
        Alamofire.request(WEATHER_URL, parameters : parameters).responseJSON {
            response in
            if response.result.isSuccess {
                let weatherData : JSON = JSON(response.result.value!)
                self.updateWeatherData(data: weatherData)
            }
            else {
                self.cityLabel.text = "Connection Issues"
            }
            
        }
    }
    

    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
   
    
    //Write the updateWeatherData method here:
    func updateWeatherData(data : JSON) {
        
        if let temp = data["main"]["temp"].double {
            
            weatherDataModel.temp = Int(temp - 273.15)
            weatherDataModel.city = data["name"].stringValue
            weatherDataModel.condition = data["weather"][0]["id"].intValue
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            
            updateUIWithWeatherData()
            
        }
        else {
            
            cityLabel.text = "weather unavailable"
            
        }
        
    }
    

    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    func updateUIWithWeatherData() {
        
        cityLabel.text = weatherDataModel.city
        temperatureLabel.text = "\(weatherDataModel.temp)°"
        weatherIcon.image = UIImage(named: "\(weatherDataModel.weatherIconName)")
        
    }
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            let parameters : Parameters = ["lat" : String(location.coordinate.latitude),
                                           "lon" : String(location.coordinate.longitude),
                                           "appid" : APP_ID]
            getWeatherData(parameters : parameters)
        }
    }
    
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavailable"
    }
    
    
    

    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    func userEnteredANewCityName(city: String) {
        
        cityLabel.text = city
        let parameters : Parameters = ["q" : city, "appid" : APP_ID]
        getWeatherData(parameters: parameters)
    }

    
    //Write the PrepareForSegue Method here
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "changeCityName" {
            let changeCityVC = segue.destination as! ChangeCityViewController
            changeCityVC.delegate = self
        }
    }
    
    
    
    
}


