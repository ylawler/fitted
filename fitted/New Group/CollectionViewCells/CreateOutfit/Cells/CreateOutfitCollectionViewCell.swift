//
//  CreateOutfitCollectionViewCell.swift
//  fitted
//
//  Created by Yannick Lawler on 23.11.20.
//

import UIKit

protocol CreateCollectionViewDelegate {
    func selected(clothingItem: clothingItem)
    
}

class CreateOutfitCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var clothingItems: [clothingItem] = []
    let itemsPerRow: CGFloat = 4
    
    var selectedIndexPaths: [IndexPath] = []
    
    var delegate: CreateCollectionViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ItemCollectionViewCell.nib(), forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
    }
    
    static let identifier = "CreateOutfitCollectionViewCellId"
    
    static func nib() -> UINib {
        return UINib(nibName: "CreateOutfitCollectionViewCell", bundle: nil)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.clothingItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as! ItemCollectionViewCell
        
//        let sectionName =
//        cell.configure(item: self.clothingItems[indexPath.item])
        
        if selectedIndexPaths.contains(indexPath) {
            cell.itemBackground.backgroundColor = .green
        } else {
            cell.itemBackground.backgroundColor = .blue
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let length = collectionView.frame.width / itemsPerRow
        
        return CGSize(width: length, height: length)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let del = self.delegate {
            if self.selectedIndexPaths.contains(indexPath) {
                if let idx = self.selectedIndexPaths.firstIndex(of: indexPath) {
                    self.selectedIndexPaths.remove(at: idx)
                }
            } else {
                self.selectedIndexPaths.append(indexPath)
            }
            self.collectionView.reloadData()
            del.selected(clothingItem: clothingItems[indexPath.item])
        }
    }

}
