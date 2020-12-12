//
//  WeatherCollectionViewCell.swift
//  fitted
//
//  Created by Yannick Lawler on 25.11.20.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var weatherBackground: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.weatherBackground.layer.cornerRadius = 12
    }
    
    static let identifier = "WeatherCollectionViewCellId"
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherCollectionViewCell", bundle: nil)
    }

}
