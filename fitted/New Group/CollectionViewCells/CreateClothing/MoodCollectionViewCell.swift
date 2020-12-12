//
//  MoodCollectionViewCell.swift
//  fitted
//
//  Created by Yannick Lawler on 25.11.20.
//

import UIKit

class MoodCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moodBackground: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.moodBackground.layer.cornerRadius = 12
    }
    
    static let identifier = "MoodCollectionViewCellId"
    
    static func nib() -> UINib {
        return UINib(nibName: "MoodCollectionViewCell", bundle: nil)
    }

}
