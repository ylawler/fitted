//
//  sectionHeaderReuseableView.swift
//  fitted
//
//  Created by Yannick Lawler on 22.11.20.
//

import UIKit

class sectionHeaderReuseableView: UICollectionReusableView {
    
    @IBOutlet weak var headerTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static let identifier = "sectionHeaderReuseableViewId"
    
    static func nib() -> UINib {
        return UINib(nibName: "sectionHeaderReuseableView", bundle: nil)
    }
    
}
