//
//  HourViewCell.swift
//  fitted
//
//  Created by Yannick Lawler on 19.02.21.
//

import UIKit

class HourViewCell: UICollectionViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(weather: currentWeather, timeHour: String) {
        timeLabel.text = timeHour
        percentageLabel.text = ""
        weatherIcon.image = weather.weather[0].getImage()
        tempLabel.text = String(format: "%.0f°", weather.main.temp)
    }
    
    static let identifier = "HourViewCellId"
    
    static func nib() -> UINib {
        return UINib(nibName: "HourViewCell", bundle: nil)
    }

}
