//
//  DiscoverCollectionViewCell.swift
//  fitted
//
//  Created by Yannick Lawler on 21.11.20.
//

import UIKit

protocol DiscoverDelegate {
    func didSelectDiscover(indexPath: IndexPath)
}

class DiscoverCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let discoverRatio: CGFloat = 1.75
    
    let discover = Discover()
    
    var delegate: DiscoverDelegate? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        
        self.collectionView.register(DiscoverByCollectionViewCell.nib(), forCellWithReuseIdentifier: DiscoverByCollectionViewCell.identifier)
        
    }
    
    static let identifier = "DiscoverCollectionViewCellId"
    
    static func nib() -> UINib {
        return UINib(nibName: "DiscoverCollectionViewCell", bundle: nil)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return discover.getCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverByCollectionViewCell.identifier, for: indexPath) as! DiscoverByCollectionViewCell
        
        
        
        
        if let discoverCategory = discover.getDiscoverCategory(forIndexPath: indexPath) {
            cell.discoverLabel.text = discoverCategory.description
            cell.discoverBackground.backgroundColor = discoverCategory.image
        }
        
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height * discoverRatio, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let del = delegate {
            del.didSelectDiscover(indexPath: indexPath)
        }
    }
}
