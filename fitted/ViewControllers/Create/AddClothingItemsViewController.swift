//
//  AddClothingItemsViewController.swift
//  fitted
//
//  Created by Yannick Lawler on 30.12.20.
//

import UIKit

class AddClothingItemsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var saveButton: UIButton!
    
    var clothingItems: [String: [Clothing]]?
    var selectedIndexPaths: [IndexPath] = []
    
    let headerHeight: CGFloat = 48
    let itemsPerRow: CGFloat = 4
    
    var selectedClothes: [Clothing] = []
    
    var ParentVC: CreateOutfitContainerViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        // Do any additional setup after loading the view.
        collectionView.register(ItemCollectionViewCell.nib(), forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
        collectionView.register(sectionHeaderReuseableView.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderReuseableView.identifier)
        
        collectionView.alwaysBounceVertical = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
//        saveSelectedClothes()
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
        return fittedCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let items = self.clothingItems else { return 0 }
        
        let category = categoryFor(section: section)
        if let clothing = items[category.name] {
            return clothing.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as! ItemCollectionViewCell
        
        guard let items = self.clothingItems else { return UICollectionViewCell() }

        let sectionName = categoryFor(section: indexPath.section)
        if let items = items[sectionName.name] {
            
            let clothingItemForCell = items[indexPath.item]
            if self.selectedClothes.contains(clothingItemForCell) {
                // We have a selected clothing Item
                if !self.selectedIndexPaths.contains(indexPath) {
                    self.selectedIndexPaths.append(indexPath)
                }
            }
            cell.configure(item:clothingItemForCell )
        }

        if self.selectedIndexPaths.contains(indexPath) {
            // Selected cell
            cell.itemBackground.backgroundColor = .green
        } else {
            cell.itemBackground.backgroundColor = blueColor
        }


        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let length = (collectionView.frame.width) / itemsPerRow
        return CGSize(width: length, height: length)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
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
        if let _ = items[category.name] {
            return CGSize(width: collectionView.frame.width, height: headerHeight)
        } else {
            return .zero
        }

    }
    
    func saveSelectedClothes() {
        if let parentVC = self.ParentVC {
            parentVC.selectedClothes = self.selectedClothes
            parentVC.selectionCollectionView.reloadData()
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        saveSelectedClothes()
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
