//
//  SearchCityViewController.swift
//  WeatherApp
//
//  Created by Mohd Saleem on 14/10/21.
//

import UIKit
import Alamofire
import RappleProgressHUD
import Kingfisher

class SearchCityViewController: UIViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate,UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    
    
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var city_List = [CityListModelClass]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tblList.register(UINib(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: "CityTableViewCell")
        
    }
    
    //List City API
    func get_list_city(searchString:String){
        RappleActivityIndicatorView.startAnimating()
        
        WeatherNetworkingClass.get_list_city_search(searchKey: searchString) {  (list,error) in
            if error == nil{
                self.city_List = list!
                self.tblList.reloadData()
                RappleActivityIndicatorView.stopAnimation()
            }
            RappleActivityIndicatorView.stopAnimation()
        }
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar)
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 0.75)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        self.searchBar.endEditing(true)
    }
    
    @objc func reload(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else {
            print("nothing to search")
            return
        }
        if query.count > 1 {
            self.get_list_city(searchString: query)
            print(query)
        }
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        self.tblList.contentOffset = CGPoint(x: 0, y: 44)
        
        let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = UIColor.white
        let whitespaceCharacterSet = CharacterSet.whitespaces
        let searchText = searchController.searchBar.text!.trimmingCharacters(in: whitespaceCharacterSet)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.city_List.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as! CityTableViewCell
        cell.selectionStyle = .none
        let model = self.city_List[indexPath.row]
        cell.lblCity.text = model.title
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityDetail = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        
        let model = self.city_List[indexPath.row]
        cityDetail!.woeid = model.woeid
        cityDetail!.isFromSearch = true
        
        self.navigationController?.pushViewController(cityDetail!, animated: true)
    }
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
}
