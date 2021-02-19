//
//  VirtualClosetCollectionViewCell.swift
//  fitted
//
//  Created by Yannick Lawler on 26.11.20.
//

import UIKit

class VirtualClosetCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var itemBackground: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        itemBackground.layer.shadowRadius = 10
//        itemBackground.layer.shadowColor = UIColor.black.cgColor
//        itemBackground.layer.shadowOffset = .zero
//        itemBackground.layer.shadowOpacity = 1
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        itemBackground.layer.borderWidth = 1
        itemBackground.layer.borderColor = blueColor.cgColor
        
//        itemBackground.layer.masksToBounds = true
//
//        itemBackground.layer.shadowRadius = 2
//        itemBackground.layer.shadowColor = UIColor.black.cgColor
//        itemBackground.layer.shadowOffset = .zero
//        itemBackground.layer.shadowOpacity = 1
        
        itemBackground.clipsToBounds = true
        
        itemBackground.layer.cornerRadius = 12
        itemBackground.backgroundColor = blueColor
    }
    
    func configureOutfit(outfit: Outfit) {
        self.itemLabel.text = outfit.name
    }
    
    func configureClothing(clothing: Clothing) {
        self.itemLabel.text = clothing.name
    }
    
    static let identifier = "VirtualClosetCollectionViewCellId"
    
    static func nib() -> UINib {
        return UINib(nibName: "VirtualClosetCollectionViewCell", bundle: nil)
    }

}
