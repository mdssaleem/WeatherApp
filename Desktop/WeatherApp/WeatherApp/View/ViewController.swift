//
//  ViewController.swift
//  WeatherApp
//
//  Created by Mohd Saleem on 14/10/21.
//

import UIKit
import RappleProgressHUD
import Alamofire
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var ImgUIView: UIView!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblTempType: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblHigh: UILabel!
    @IBOutlet weak var lblLow: UILabel!
    @IBOutlet weak var line1: UIView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var line2: UIView!
    @IBOutlet weak var lblRise: UILabel!
    @IBOutlet weak var lblHide: UILabel!
    @IBOutlet weak var lblRiseValue: UILabel!
    @IBOutlet weak var lblHideVlaue: UILabel!
    @IBOutlet weak var line3: UIView!
    @IBOutlet weak var lblWindD: UILabel!
    @IBOutlet weak var lblWindS: UILabel!
    @IBOutlet weak var lblWindDValue: UILabel!
    @IBOutlet weak var lblWindSVlaue: UILabel!
    @IBOutlet weak var line4: UIView!
    @IBOutlet weak var lblHum: UILabel!
    @IBOutlet weak var lblVis: UILabel!
    @IBOutlet weak var lblHumValue: UILabel!
    @IBOutlet weak var lblVisVlaue: UILabel!
    @IBOutlet weak var line5: UIView!
    @IBOutlet weak var btn5DaysTemp: UIButton!
    
    
    var weatherDataList = [WeatherItemsModelClass]()
    var woeid:Int?
    var isFromSearch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isFromSearch{
            isFromSearch = false
            
        }else{
            woeid = 28743736
        }
        
        btn5DaysTemp.layer.cornerRadius = btn5DaysTemp.frame.height / 2
        btn5DaysTemp.layer.borderWidth = 1
        btn5DaysTemp.layer.borderColor = UIColor.white.cgColor
        btn5DaysTemp.clipsToBounds = true
        ImgUIView.layer.cornerRadius = ImgUIView.frame.height / 2
        ImgUIView.layer.borderWidth = 0
        ImgUIView.layer.borderColor = UIColor.white.cgColor
        ImgUIView.clipsToBounds = true
        self.getWeatherdata()
    }
    
    
    
    @objc func getWeatherdata()  {
        
        RappleActivityIndicatorView.startAnimating()
        
        WeatherNetworkingClass.getWeatherData(woeid:woeid!) {  (json,error,title,woeid,sun_rise,sun_set) in
            if error == nil{
                self.lblCity.text = title
                self.weatherDataList = json!
                
                let model = self.weatherDataList[0]
                self.lblTempType.text = model.weather_state_name
                self.lblTemp.text =  "\(model.the_temp!)°"
                self.lblLow.text = "Low : \(model.min_temp!)°"
                self.lblHigh.text = "High : \(model.max_temp!)°"
                self.lblDescription.text = "Today : \(model.weather_state_name!) currently. The high will be \(model.max_temp!) and Low \(model.min_temp!)"
                self.lblRiseValue.text = self.convertDateFormat(inputDate: sun_rise!)
                self.lblHideVlaue.text = self.convertDateFormat(inputDate: sun_set!)
                self.lblWindDValue.text! = model.wind_direction_compass ?? "NA"
                self.lblWindSVlaue.text = "\(model.wind_speed!) MPH"
                self.lblHumValue.text = "\(model.humidity!)%"
                self.lblVisVlaue.text = "\(model.visibility!) MILE"
                
                if let imgURL = model.weather_state_abbr{
                    self.img.kf.setImage(with: URL(string:NetworkingConstant.WeatherImageApi+"\(model.weather_state_abbr!).png"), placeholder: UIImage(named: "icons8-sun-96"))
                }
                RappleActivityIndicatorView.stopAnimation()
            }
            RappleActivityIndicatorView.stopAnimation()
        }
        
    }
    
    
    func convertDateFormat(inputDate: String) -> String {
        
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let oldDate = olDateFormatter.date(from: inputDate)
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "h:mm a"
        return convertDateFormatter.string(from: oldDate!)
    }
    
    @IBAction func btn5DaysWeatherAction(_ sender: Any) {
        
        let nv = self.storyboard?.instantiateViewController(withIdentifier: "UpcomingWeatherViewController") as? UpcomingWeatherViewController
        nv!.weatherDataList = weatherDataList
        self.navigationController?.pushViewController(nv!, animated: true)
    }
    
    @IBAction func searchWeatherAction(_ sender: Any) {
        let nv = self.storyboard?.instantiateViewController(withIdentifier: "SearchCityViewController") as? SearchCityViewController
        self.navigationController?.pushViewController(nv!, animated: true)
    }
    
}

