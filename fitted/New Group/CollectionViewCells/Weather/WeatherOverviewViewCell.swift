//
//  WeatherOverviewViewCell.swift
//  fitted
//
//  Created by Yannick Lawler on 18.02.21.
//

import UIKit

class WeatherOverviewViewCell: UICollectionViewCell {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var minMaxLabel: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(weather: currentWeather) {
        
        let weatherData = weather.weather[0]
        
        self.weatherImage.image = weatherData.getImage()
        self.tempLabel.text = String(format: "%.0f°", weather.main.temp)
        
        self.minMaxLabel.text = String(format: "%.0f° / %.0f°", weather.main.temp_max, weather.main.temp_min)
            
        self.weatherDescription.text = "\(weatherData.description)"
        self.locationLabel.text = "\(weather.sys.country)"
        
    }
    
    static let identifier = "WeatherOverviewViewCellId"
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherOverviewViewCell", bundle: nil)
    }

}
