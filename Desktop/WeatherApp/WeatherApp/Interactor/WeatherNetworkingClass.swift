//
//  WeatherNetworkingClass.swift
//  WeatherApp
//
//  Created by Mohd Saleem on 14/10/21.
//

import Foundation
import SwiftyJSON
import RappleProgressHUD
import Alamofire


class WeatherNetworkingClass{
    
    
    
    static func getWeatherData(woeid:Int, completion:@escaping ([WeatherItemsModelClass]?,NSError?,String?,String?,String?,String?) -> Void){
        
        
        Alamofire.request(NetworkingConstant.WeatherApi+NetworkingConstant.location+"/\(woeid)", method: .post, encoding: JSONEncoding.default,headers:nil).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                var weatherData = [WeatherItemsModelClass]()
                for(i, subJson) in json["consolidated_weather"]{
                    let weather = WeatherItemsModelClass(weatherData: subJson)
                    weatherData.append(weather)
                    
                }
                let title = json["title"].stringValue
                let woeid = json["woeid"].stringValue
                let sun_rise = json["sun_rise"].stringValue
                let sun_set = json["sun_set"].stringValue
                
                
                
                completion(weatherData,nil,title,woeid,sun_rise,sun_set)
            case .failure(let error):
                if  error.localizedDescription == "The Internet connection appears to be offline."
                {
                    let actionController = UIAlertController(title:  "Alert", message:  "The Internet connection appears to be offline.", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
                    }
                    actionController.addAction(ok)
                    //UIApplication.topViewController()?.present(actionController, animated: true, completion: nil)
                }
                
                completion(nil,error as NSError?,nil,nil,nil,nil)
            }
        }
        
    }
    
    static func get_list_city_search(searchKey:String?, completion:@escaping ([CityListModelClass]?,NSError?) -> Void){
        
        let todoEndpoint: String = NetworkingConstant.WeatherApi+NetworkingConstant.search+searchKey!
        Alamofire.request(todoEndpoint, method: .get)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    //print(json)
                    var popularArray = [CityListModelClass]()
                    
                    
                    
                    for(_, subJson) in json{
                        let popularData = CityListModelClass(cityData: subJson)
                        popularArray.append(popularData)
                    }
                    
                    
                    completion(popularArray,nil)
                case .failure(let error):
                    if  error.localizedDescription == "The Internet connection appears to be offline."
                    {
                        let actionController = UIAlertController(title:  "Alert", message:  "The Internet connection appears to be offline.", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
                        }
                        actionController.addAction(ok)
                        
                    }
                    
                    completion([],error as NSError?)
                }
            }
    }
    
}
