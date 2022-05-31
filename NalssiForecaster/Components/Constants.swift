//
//  Constants.swift
//  NalssiForecaster
//
//  Created by Kevin Mattocks on 5/31/22.
//

import Foundation


struct Constants {
    static var apiKey = "a2b1b988c9ada938effee059a40d02b5"
    
    static func tempToString(_ temp: Double) -> String {
        return String(format: "%.f°", temp)
    }
    
    static func dtConversion(_ unix: Double) -> String {
        
        let date = Date(timeIntervalSince1970: unix)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h a"
        
        
        return dateFormatter.string(from: date)
        
        //Allows us to pass in a date and return a string in the format we specify
    }
    
    static func dtDaily(_ unix: Double) -> String {
        
        let date = Date(timeIntervalSince1970: unix)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        
        
        return dateFormatter.string(from: date)
        
        //Allows us to pass in a date and return a string in the format we specify
    }
    
}
