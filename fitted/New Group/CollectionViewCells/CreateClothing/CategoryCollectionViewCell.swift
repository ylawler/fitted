//
//  CategoryCollectionViewCell.swift
//  fitted
//
//  Created by Yannick Lawler on 26.11.20.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryBackground: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        categoryBackground.layer.cornerRadius = 12
    }
    
    static let identifier = "CategoryCollectionViewCellId"
    
    static func nib() -> UINib {
        return UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
    }

}
