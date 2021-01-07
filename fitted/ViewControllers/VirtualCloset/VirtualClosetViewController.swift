//
//  VirtualClosetViewController.swift
//  fitted
//
//  Created by Yannick Lawler on 29.12.20.
//

import UIKit

class VirtualClosetViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    let itemsPerRow: CGFloat = 4
    let headerHeight: CGFloat = 32
    
    let coreDataManager = CoreDataManager()
    
    var Clothes: [String: [Clothing]] = [:]
    var Outfits: [Outfit] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        coreDataManager.loadClothing { (successful, ClothingItems) in
            if successful {
                self.Clothes = ClothingItems
            }
        }
        
        coreDataManager.loadOutfits { (successful, outfits) in
            if successful {
                self.Outfits = outfits
            }
        }
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(VirtualClosetCollectionViewCell.nib(), forCellWithReuseIdentifier: VirtualClosetCollectionViewCell.identifier)
        collectionView.register(sectionHeaderReuseableView.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderReuseableView.identifier)
        collectionView.alwaysBounceVertical = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return 1
        case 1:
            return Categories.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            // Outfit
            return Outfits.count
        case 1:
            // Clothing
            let category = categoryFor(section: section)
            if let clothing = self.Clothes[category.name] {
                return clothing.count
            } else {
                return 0
            }
        
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VirtualClosetCollectionViewCell.identifier, for: indexPath) as! VirtualClosetCollectionViewCell
        
        // Configure the cell
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            cell.configureOutfit(outfit: Outfits[indexPath.item])
            printOutfit(outfit: Outfits[indexPath.item])
        case 1:
            
            
            let sectionCategory = categoryFor(section: indexPath.section)
            if let sectionClothingItems = Clothes[sectionCategory.name] {
                cell.configureClothing(clothing: sectionClothingItems[indexPath.item])
            }
            
            
        default:
            print("Error with segmentedControl")
        }
        
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let length = collectionView.frame.width/itemsPerRow
        return CGSize(width: length, height: length)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderReuseableView.identifier, for: indexPath) as! sectionHeaderReuseableView
        
        if segmentedControl.selectedSegmentIndex == 1 {
            let category = self.categoryFor(section: indexPath.section)
            header.headerTitle.text = category.name
        }
        
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return .zero
        case 1:
            // get category for section
            let category = self.categoryFor(section: section)
            if let _ = self.Clothes[category.name] {
                return CGSize(width: collectionView.frame.width, height: headerHeight)
            } else {
                return .zero
            }
        default:
            return .zero
        }
        
        
    }
    
    @IBAction func segmentTapped(_ sender: UISegmentedControl) {
        print("after tapped, index: \(sender.selectedSegmentIndex)")
        self.collectionView.reloadData()
    }
    
    @IBAction func refreshButtonTapped(_ sender: UIButton) {
        self.collectionView.reloadData()
    }
    
}
