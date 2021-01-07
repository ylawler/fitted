//
//  SelectedItemCollectionViewCell.swift
//  fitted
//
//  Created by Yannick Lawler on 23.11.20.
//

import UIKit

protocol selectedCollectionViewDelegate {
    func remove()
}

class SelectedItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var selectedBackground: UIImageView!
    @IBOutlet weak var selectedLabel: UILabel!
    
    @IBOutlet weak var removeButton: UIButton!
    
    
    var clothing: Clothing?
    
    var delegate: selectedCollectionViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.removeButton.isHidden = true
    }
    
    func configureRemove() {
        self.removeButton.isHidden = !self.removeButton.isHidden
    }
    
    
    
    func configure(clothing: Clothing){
        self.selectedLabel.text = clothing.name
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.selectedBackground.layer.cornerRadius = (96 - 16)/2
        self.selectedBackground.layer.borderWidth = 2
        self.selectedBackground.layer.borderColor = UIColor.green.cgColor
        self.selectedBackground.backgroundColor = .lightGray
    }
    
    static let identifier = "SelectedItemCollectionViewCellId"
    
    static func nib() -> UINib {
        return UINib(nibName: "SelectedItemCollectionViewCell", bundle: nil)
    }


    @IBAction func didTapRemove(_ sender: UIButton) {
        if let del = self.delegate {
            del.remove()
        }
    }
}
