//
//  CreateOutfitCollectionReusableView.swift
//  fitted
//
//  Created by Yannick Lawler on 23.11.20.
//

import UIKit

class CreateOutfitCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var headerLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static let identifier = "CreateOutfitCollectionReusableViewId"
    
    static func nib() -> UINib {
        return UINib(nibName: "CreateOutfitCollectionReusableView", bundle: nil)
    }
    
}
