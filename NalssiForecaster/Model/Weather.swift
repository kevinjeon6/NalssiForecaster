//
//  Weather.swift
//  NalssiForecaster
//
//  Created by Kevin Mattocks on 5/31/22.
//

import Foundation


struct Weather: Decodable {
    var current: Current
    var hourly: [Current]
    var daily: [Daily]
    
    //Hourly is an array of weather responses (i.e. Current). It parses the data because the array is similar to Current properties
}

struct Current: Decodable, Identifiable {
    let id = UUID()
    var dt: Double
    var temp: Double
    var feels_like: Double
    var weather: [WeatherInfo]
}

struct WeatherInfo: Decodable {
    var description: String
}

struct Daily: Decodable, Identifiable {
    
    let id = UUID()
    var dt: Double
    var temp: DailyTemp
}

struct DailyTemp: Decodable {
    var min: Double
    var max: Double
}
