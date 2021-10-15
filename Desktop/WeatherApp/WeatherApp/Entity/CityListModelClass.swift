//
//  CityListModelClass.swift
//  WeatherApp
//
//  Created by Mohd Saleem on 14/10/21.
//

import Foundation
import SwiftyJSON




class CityListModelClass {
    

    var title: String?
    var woeid: Int?

    init(cityData:JSON){
        
        self.title = cityData["title"].stringValue
        self.woeid = cityData["woeid"].intValue
        
    }
    
    init() {
        
        self.title = ""
        self.woeid = 0
        
    }
}
