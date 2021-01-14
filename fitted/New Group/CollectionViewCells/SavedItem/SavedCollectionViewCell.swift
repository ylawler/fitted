//
//  SavedCollectionViewCell.swift
//  fitted
//
//  Created by Yannick Lawler on 23.11.20.
//

import UIKit

class SavedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var minMaxLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var moodLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = blueColor
    }
    
    func configure(outfit: Outfit) {
        print("configuring: \(outfit.id!)")
        imageView.image = UIImage(systemName: "person")
        nameLabel.text = outfit.name
        minMaxLabel.text = "\(outfit.minTemp ?? "NONE")°C / \(outfit.maxTemp ?? "NONE")°C"
        weatherLabel.text = outfit.weather
        moodLabel.text = outfit.mood
    }
    
    static let identifier = "SavedCollectionViewCellId"
    
    static func nib() -> UINib {
        return UINib(nibName: "SavedCollectionViewCell", bundle: nil)
    }

}
