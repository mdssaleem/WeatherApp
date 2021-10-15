//
//  UpcomingWeatherViewController.swift
//  WeatherApp
//
//  Created by Mohd Saleem on 14/10/21.
//

import UIKit

class UpcomingWeatherViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var weatherDataList = [WeatherItemsModelClass]()
    @IBOutlet weak var weatherTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        weatherTableView.tableFooterView = UIView()
        weatherTableView.register(UINib(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherTableViewCell")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
        
        cell.selectionStyle = .none
        let model = self.weatherDataList[indexPath.row]
        cell.lblLow.text = "- Min : \(model.min_temp!)°"
        cell.lblHigh.text = "Max : \(model.max_temp!)°"
        cell.lblTempType.text = model.weather_state_name
        cell.lblCity.text = self.convertDateFormat(inputDate: model.applicable_date!)
        
        if let imgURL = model.weather_state_abbr{
            cell.img.kf.setImage(with: URL(string:NetworkingConstant.WeatherImageApi+"\(model.weather_state_abbr!).png"), placeholder: UIImage(named: "icons8-sun-96"))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func convertDateFormat(inputDate: String) -> String {
        
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy-MM-dd"
        let oldDate = olDateFormatter.date(from: inputDate)
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "EEEE"
        return convertDateFormatter.string(from: oldDate!)
    }
    
}
