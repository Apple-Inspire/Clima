//
//  ChangeCityViewController.swift
//  WeatherApp
//
//  Created by Himanshu on 11/05/2018.
//  Copyright (c) 2018 Inspire Infotech Pvt Ltd. All rights reserved.
//

import UIKit


//Write the protocol declaration here:

protocol ChangeCityDelegate{
    func userEnteredANewCityName(city: String)
    
}

class ChangeCityViewController: UIViewController {
    
    
    
    
    //Declare the delegate variable here:
    var delegate: ChangeCityDelegate?
    
    //This is the pre-linked IBOutlets to the text field:
    @IBOutlet weak var changeCityTextField: UITextField!
    
    
    //This is the IBAction that gets called when the user taps on the "Get Weather" button:
    @IBAction func getWeatherPressed(_ sender: AnyObject) {
        
        let cityName = changeCityTextField.text!
        delegate?.userEnteredANewCityName(city: cityName)
        self.dismiss(animated: true, completion: nil)
        
        //1 Get the city name the user entered in the text field
        
        
        //2 If we have a delegate set, call the method userEnteredANewCityName
        
        
        //3 dismiss the Change City View Controller to go back to the WeatherViewController
        
        
    }
    

    

    

    //This is the IBAction that gets called when the user taps the back button. It dismisses the ChangeCityViewController.
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
