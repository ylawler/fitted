//
//  WeatherForecastViewCell.swift
//  fitted
//
//  Created by Yannick Lawler on 18.02.21.
//

import UIKit

class WeatherForecastViewCell: UICollectionViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var minMaxLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(weather: currentWeather) {
        dateLabel.text = "Friday, 19th Feb."
        weatherIcon.image = weather.weather[0].getImage()
        minMaxLabel.text = String(format: "%.0f° / %.0f°", weather.main.temp_max, weather.main.temp_min)
    }
    
    static let identifier = "WeatherForecastViewCellId"
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherForecastViewCell", bundle: nil)
    }

}
