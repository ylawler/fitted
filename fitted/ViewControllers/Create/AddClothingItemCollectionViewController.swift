//
//  AddClothingItemCollectionViewController.swift
//  fitted
//
//  Created by Yannick Lawler on 03.12.20.
//

import UIKit

private let reuseIdentifier = "Cell"

class AddClothingItemCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var clothingItems: [String: [Clothing]]?
    var selectedIndexPaths: [IndexPath] = []
    
    let headerHeight: CGFloat = 48
    let itemsPerRow: CGFloat = 4
    
    var selectedClothes: [Clothing] = []
    
    var ParentVC: CreateOutfitContainerViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        collectionView.register(ItemCollectionViewCell.nib(), forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
        collectionView.register(sectionHeaderReuseableView.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderReuseableView.identifier)
        
        
//        collectionView.register(CreateOutfitCollectionViewCell.nib(), forCellWithReuseIdentifier: CreateOutfitCollectionViewCell.identifier)
//        collectionView.register(CreateOutfitCollectionReusableView.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CreateOutfitCollectionReusableView.identifier)

        // Do any additional setup after loading the view.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
      
        
    }
    

    // MARK: UICollectionViewDataSource
    
    override func viewDidDisappear(_ animated: Bool) {
        if let parentVC = self.ParentVC {
            print("WE HAVE A PARENT VC")
            print("selected: \(selectedClothes)")
            parentVC.selectedClothes = self.selectedClothes
            parentVC.selectionCollectionView.reloadData()
        } else {
            print("SOMETHING WENT WRONG WITH THE VC")
        }
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        print("View will disappear")
//        print("selected: \(selectedClothes)")
//
//        let tabBarVC = self.presentingViewController as! UITabBarController
//
//        guard let parent = tabBarVC.viewControllers![1] as? CreateOutfitContainerViewController else { return } // This should be the OutfitContainerVC
//
//        parent.selectedClothes = self.selectedClothes
//        print("parentVC selected CLothes: \(parent.selectedClothes)")
//        parent.selectionCollectionView.reloadData()
//    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        
        return Categories.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        guard let items = self.clothingItems else { return 0 }
        
        let category = categoryFor(section: section)
        if let clothing = items[category.name] {
            return clothing.count
        } else {
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as! ItemCollectionViewCell
        
        guard let items = self.clothingItems else { return UICollectionViewCell() }

        let sectionName = categoryFor(section: indexPath.section)
        if let items = items[sectionName.name] {

            cell.configure(item: items[indexPath.item])
        }

        if self.selectedIndexPaths.contains(indexPath) {
            // Selected cell
            cell.itemBackground.backgroundColor = .lightGray
        } else {
            cell.itemBackground.backgroundColor = blueColor
        }


        return cell
    }

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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let length = (collectionView.frame.width) / itemsPerRow
        return CGSize(width: length, height: length)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        guard let items = self.clothingItems else { return }
        
        if let selectedClothing = getItem(forIndexPath: indexPath, clothingItems: items) {
            print("selected item at \(indexPath) -> \(String(describing: selectedClothing.name))")

            // Remove or append the selectedIndexPath
            if self.selectedIndexPaths.contains(indexPath) {
                print("...selectedINdexPaths contains indexPath -> true : \(indexPath)")
                if let idx = self.selectedIndexPaths.firstIndex(of: indexPath) {
                    print("...idx = \(idx)")
                    print("...item= \(selectedIndexPaths[idx])")
                    self.selectedIndexPaths.remove(at: idx)
                } else {
                    print("...error with finding idx")
                }
            } else {
                print("...selectedIndexPaths contrains indexPath -> false : \(indexPath)")
                self.selectedIndexPaths.append(indexPath)
            }

            if selectedClothes.contains(selectedClothing) {
                if let idx = selectedClothes.firstIndex(of: selectedClothing) {
                    selectedClothes.remove(at: idx)
                }
            } else {
                selectedClothes.append(selectedClothing)
            }


            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeaderReuseableView.identifier, for: indexPath) as! sectionHeaderReuseableView
            let category = self.categoryFor(section: indexPath.section)
            header.headerTitle.text = category.name
            return header
        } else {
            return UICollectionReusableView()
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let items = self.clothingItems else { return .zero }
        // get category for section
        let category = self.categoryFor(section: section)
        if let itemsForSection = items[category.name] {
            return CGSize(width: collectionView.frame.width, height: headerHeight)
        } else {
            return .zero
        }

    }

}
