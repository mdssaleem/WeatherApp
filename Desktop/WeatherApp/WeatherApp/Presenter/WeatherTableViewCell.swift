//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Mohd Saleem on 14/10/21.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var ImgUIView: UIView!
    
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblTempType: UILabel!
    @IBOutlet weak var lblHigh: UILabel!
    @IBOutlet weak var lblLow: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        ImgUIView.layer.cornerRadius = ImgUIView.frame.height / 2

        ImgUIView.layer.borderWidth = 0
        ImgUIView.layer.borderColor = UIColor.white.cgColor
        ImgUIView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
