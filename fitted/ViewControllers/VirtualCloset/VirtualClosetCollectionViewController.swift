//
//  VirtualClosetCollectionViewController.swift
//  fitted
//
//  Created by Yannick Lawler on 26.11.20.
//

import UIKit

private let reuseIdentifier = "Cell"

class VirtualClosetCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var Clothes: [String: [Clothing]] = [:]
    var Outfits: [Outfit] = []
    
    let headerHeight: CGFloat = 32
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    let coreDataManager = CoreDataManager()

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
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.register(VirtualClosetCollectionViewCell.nib(), forCellWithReuseIdentifier: VirtualClosetCollectionViewCell.identifier)
        self.collectionView.register(sectionHeaderReuseableView.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderReuseableView.identifier)
        
        self.collectionView.alwaysBounceVertical = true

        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return 1
        case 1:
            return fittedCategories.count
        default:
            return 0
        }
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
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

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
        return CGSize(width: collectionView.frame.width/4, height: collectionView.frame.width/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
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
    
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CreateOutfitCollectionReusableView.identifier, for: indexPath) as! CreateOutfitCollectionReusableView
//        let category = self.categoryFor(section: indexPath.section)
//        header.headerLabel.text = category.name
//        return header
//
//    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

    @IBAction func segmentedControlTapped(_ sender: UISegmentedControl) {
        print("after tapped, index: \(sender.selectedSegmentIndex)")
        self.collectionView.reloadData()
    }
}
