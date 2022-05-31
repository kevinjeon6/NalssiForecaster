//
//  WeatherViewModel.swift
//  NalssiForecaster
//
//  Created by Kevin Mattocks on 5/31/22.
//

import CoreLocation
import Foundation
import SwiftUI



class WeatherViewModel: ObservableObject {
    
    //Declare published property wrapper, that when the the property value changes, we want to notifty anyone who is observing it
    @Published var weatherData: Weather?
    @AppStorage("cityName") var cityName = ""
    


    init(){
        getWeatherData(cityName)
    }
    //Init method gets run when a new instance of WeatherModel is created
    
    
    //MARK: - OpenWeatherMap API methods
    
    
    func getWeatherData(_ cityName: String){
        CLGeocoder().geocodeAddressString(cityName){(placemarks, error ) in
            if let error = error {
                print(error)
            }
            if let lat = placemarks?.first?.location?.coordinate.latitude,
                let lon = placemarks?.first?.location?.coordinate.longitude {
                //first is the first element of the collection
                let weatherUrlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely,alerts&units=imperial&appid=\(Constants.apiKey)"
                
                let weatherUrl = URL(string: weatherUrlString)
                guard weatherUrl != nil else {
                    return
                }
                
                let request = URLRequest(url: weatherUrl!)
                
                //Create a URL session
                
                let session = URLSession.shared
                let dataTask = session.dataTask(with: request) { data, response, error in
                    guard error == nil else {
                        return
                    }
                    
                    do{
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(Weather.self, from: data!)
//                        decoder.dateDecodingStrategy = .secondsSince1970
                  
                        //parsing the weather data into the constant, result
                        
                        //Add UUId's to the hourly weather objects. Use the variable Result since that is parsing the weather
                        //Don't need loop if set let id = UUID()
//                        for i in 0..<result.hourly.count {
//                                result.hourly[i].id = UUID()
//                        }
                        
//
                        
                        DispatchQueue.main.async {
                            self.weatherData = result
    
                        }
                        
                    }catch {
                        print(error)
                    }
                }
                dataTask.resume()
            }
           }
    }//func getWeatherData
    
}

