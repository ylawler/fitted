//
//  DiscoverByCollectionViewCell.swift
//  fitted
//
//  Created by Yannick Lawler on 21.11.20.
//

import UIKit

class DiscoverByCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var discoverBackground: UIImageView!
    @IBOutlet weak var discoverLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.discoverBackground.layer.cornerRadius = 12
        self.discoverBackground.layer.masksToBounds = false
        self.discoverBackground.layer.shadowColor = UIColor.black.cgColor
        self.discoverBackground.layer.shadowRadius = 4
        self.discoverBackground.layer.shadowOpacity = 1
        self.discoverBackground.layer.shadowOffset = .zero
        self.discoverBackground.clipsToBounds = true
    }
    
    
    
    static let identifier = "DiscoverByCollectionViewCellId"
    
    static func nib() -> UINib {
        return UINib(nibName: "DiscoverByCollectionViewCell", bundle: nil)
    }

}
