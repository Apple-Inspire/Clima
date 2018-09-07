//
//  ViewController.swift
//  WeatherApp
//
//  Created by Himanshu on 11/05/2018.
//  Copyright (c) 2018 Inspire Infotech Pvt Ltd. All rights reserved.

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON


class WeatherViewController: UIViewController ,CLLocationManagerDelegate, ChangeCityDelegate {
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "e72ca729af228beabd5d20e3b7749713"
    //let APP_ID = "b6907d289e10d714a6e88b30761fae22"
    
    
    //TODO: Declare instance variables here
    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        print(locValue.latitude)
        print(locValue.longitude)
       let latitude = String(locValue.latitude)
        let longitude = String(locValue.longitude)
        
        let parms: [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
        
      getWeatherData(url: WEATHER_URL, parameter: parms)
        //mapView1.setRegion(viewRegion, animated: false)
        
        // self.map.setRegion(UIRegion, animated: true)
        //return (locValue.latitude)
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    
    func getWeatherData(url : String,parameter : [String: String]) {
        Alamofire.request(url, method: .get, parameters: parameter).responseJSON{
                response in
                if response.result.isSuccess{
                    let weatherJSON : JSON = JSON(response.result.value!)
                    print(weatherJSON)
                    self.updateWeth(json: weatherJSON)
                }
                else{
                    print("Error")
                }
        }
    }
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    //Write the updateWeatherData method here:
    func updateWeth(json : JSON)
    {
        let temp = json["main"]["temp"].doubleValue
        
        weatherDataModel.temp = Int(temp - 273.15)
        weatherDataModel.city = json["name"].stringValue
        weatherDataModel.cond = json["weather"][0]["id"].intValue
        weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.cond)
        updateUIWithWeatherData()
    }
    
    
    //MARK: - UI Updates
    /***************************************************************/

    //Write the updateUIWithWeatherData method here:
    
    func updateUIWithWeatherData()
    {
        cityLabel.text = weatherDataModel.city
        temperatureLabel.text = "\(weatherDataModel.temp)"
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    

    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    //Write the didUpdateLocations method here:

    
    //Write the didFailWithError method here:
    
   
    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    func userEnteredANewCityName(city: String){
        let params: [String:String] = ["q": city ,"appid" : APP_ID]
        getWeatherData(url: WEATHER_URL, parameter: params)
    }
    
    
    //Write the PrepareForSegue Method here
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName"{
            let destinationVC = segue.destination as! ChangeCityViewController
            destinationVC.delegate = self
        }
    }
    
    
}


