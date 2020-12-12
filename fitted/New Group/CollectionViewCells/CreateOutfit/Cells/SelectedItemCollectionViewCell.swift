//
//  SelectedItemCollectionViewCell.swift
//  fitted
//
//  Created by Yannick Lawler on 23.11.20.
//

import UIKit

class SelectedItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var selectedBackground: UIImageView!
    @IBOutlet weak var selectedLabel: UILabel!
    
    var clothing: Clothing?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func configure(clothing: Clothing){
        self.selectedLabel.text = clothing.name
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.selectedBackground.layer.cornerRadius = (96 - 16)/2
        self.selectedBackground.layer.borderWidth = 1
        self.selectedBackground.layer.borderColor = UIColor.purple.cgColor
    }
    
    static let identifier = "SelectedItemCollectionViewCellId"
    
    static func nib() -> UINib {
        return UINib(nibName: "SelectedItemCollectionViewCell", bundle: nil)
    }


}
