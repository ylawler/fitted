//
//  ItemCollectionViewCell.swift
//  fitted
//
//  Created by Yannick Lawler on 23.11.20.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemBackground: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        itemBackground.layer.cornerRadius = 12
    }
    
    func configure(item: Clothing) {
        self.itemLabel.text = item.name
    }

    static let identifier = "ItemCollectionViewCellId"
    
    static func nib() -> UINib {
        return UINib(nibName: "ItemCollectionViewCell", bundle: nil)
    }
}
