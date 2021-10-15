//
//  WeatherItemsModelClass.swift
//  WeatherApp
//
//  Created by Mohd Saleem on 14/10/21.
//

import Foundation
import SwiftyJSON




class WeatherItemsModelClass {


    var id: Int?
    var weather_state_name: String?
    var weather_state_abbr: String?
    var wind_direction_compass: String?
    var created: String?
    var applicable_date: String?
    var min_temp: Int?
    var max_temp: Int?
    var the_temp: Int?
    var wind_speed: Int?
    var humidity: Int?
    var visibility: Int?
    var predictability: Int?

    init(weatherData:JSON){
        
        self.id = weatherData["id"].intValue
        self.weather_state_name = weatherData["weather_state_name"].stringValue
        self.weather_state_abbr = weatherData["weather_state_abbr"].stringValue
        self.wind_direction_compass = weatherData["wind_direction_compass"].stringValue
        self.created = weatherData["created"].stringValue
        self.applicable_date = weatherData["applicable_date"].stringValue
        self.min_temp = weatherData["min_temp"].intValue
        self.max_temp = weatherData["max_temp"].intValue
        self.the_temp = weatherData["the_temp"].intValue
        self.wind_speed = weatherData["wind_speed"].intValue
        self.humidity = weatherData["humidity"].intValue
        self.visibility = weatherData["visibility"].intValue
        self.predictability = weatherData["predictability"].intValue
        
    }
    
    init() {
        
        self.id = 0
        self.weather_state_name = ""
        self.weather_state_abbr = ""
        self.wind_direction_compass = ""
        self.created = ""
        self.applicable_date = ""
        self.min_temp = 0
        self.max_temp = 0
        self.the_temp = 0
        self.wind_speed = 0
        self.humidity = 0
        self.visibility = 0
        self.predictability = 0

        
    }
}
