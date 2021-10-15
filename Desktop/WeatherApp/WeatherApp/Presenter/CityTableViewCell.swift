//
//  CityTableViewCell.swift
//  WeatherApp
//
//  Created by Mohd Saleem on 14/10/21.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    @IBOutlet weak var lblCity: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
