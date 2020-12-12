//
//  SavedCollectionViewCell.swift
//  fitted
//
//  Created by Yannick Lawler on 23.11.20.
//

import UIKit

class SavedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var savedBackground: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        savedBackground.layer.cornerRadius = 12
    }
    
    static let identifier = "SavedCollectionViewCellId"
    
    static func nib() -> UINib {
        return UINib(nibName: "SavedCollectionViewCell", bundle: nil)
    }

}
