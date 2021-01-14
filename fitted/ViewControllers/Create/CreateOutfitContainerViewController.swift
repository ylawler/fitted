//
//  CreateOutfitContainerViewController.swift
//  fitted
//
//  Created by Yannick Lawler on 23.11.20.
//

import UIKit

struct clothingItem: Equatable {
    let name: String
}

public let blueColor = UIColor(red: 26/255, green: 48/255, blue: 68/255, alpha: 1)

class CreateOutfitContainerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, selectedCollectionViewDelegate {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var selectionCollectionView: UICollectionView!
    @IBOutlet weak var newOutfitImageButton: UIButton!
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var minTxtField: UITextField!
    @IBOutlet weak var maxTxtField: UITextField!
    
    @IBOutlet weak var clothingItemsBackground: UIView!
    
    var coreDataManager: CoreDataManager?
    
    
    let headerHeight: CGFloat = 32
    let itemsPerRow: CGFloat = 4
    
    var clothingItems: [String: [Clothing]] = [:]
    var selectedIndexPaths: [IndexPath] = []
    var selectionViewSelectedIndexPath: IndexPath?
    
    var selectedMoods: [Mood] = []
    var selectedWeathers: [Weather] = []
    
    var selectedClothes: [Clothing] = []
    var imageSelected: Bool = false
    
    let sections = ["Weather", "Mood"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        newOutfitImageButton.layer.cornerRadius = 12
        newOutfitImageButton.backgroundColor = blueColor
        clothingItemsBackground.layer.cornerRadius = 12
        clothingItemsBackground.backgroundColor = blueColor
        selectionCollectionView.backgroundColor = .clear
        
        
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        selectionCollectionView.delegate = self
        selectionCollectionView.dataSource = self
        
        selectionCollectionView.register(SelectedItemCollectionViewCell.nib(), forCellWithReuseIdentifier: SelectedItemCollectionViewCell.identifier)
        selectionCollectionView.alwaysBounceHorizontal = true
        
        // V.2
        collectionView.register(WeatherCollectionViewCell.nib(), forCellWithReuseIdentifier: WeatherCollectionViewCell.identifier)
        collectionView.register(MoodCollectionViewCell.nib(), forCellWithReuseIdentifier: MoodCollectionViewCell.identifier)
        collectionView.register(sectionHeaderReuseableView.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderReuseableView.identifier)
        
        // old cells
       

        collectionView.alwaysBounceVertical = true
        
        
    }
    
    
    func update(Clothes: [String: [Clothing]]) {
        
        for clothes in Clothes {
            self.clothingItems.updateValue(clothes.value, forKey: clothes.key)
        }
        
        self.collectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        switch collectionView {
        case self.collectionView:
            return sections.count
        case selectionCollectionView:
            return 1
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        switch collectionView {
        case self.collectionView:
            
            
            if section == 0 {
                return Weathers.count
            } else {
                return Moods.count
            }
            

            
        case selectionCollectionView:
            return selectedClothes.count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        switch collectionView {
        case self.collectionView:
            
            
            if indexPath.section == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as! WeatherCollectionViewCell
                
                if selectedIndexPaths.contains(indexPath) {
                    cell.weatherBackground.backgroundColor = .green
                } else {
                    cell.weatherBackground.backgroundColor = blueColor
                }
                
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoodCollectionViewCell.identifier, for: indexPath) as! MoodCollectionViewCell
                
                if selectedIndexPaths.contains(indexPath) {
                    cell.moodBackground.backgroundColor = .green
                } else {
                    cell.moodBackground.backgroundColor = blueColor
                }
                
                return cell
            }
        case selectionCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedItemCollectionViewCell.identifier, for: indexPath) as! SelectedItemCollectionViewCell
            cell.configure(clothing: selectedClothes[indexPath.item])
            
            if let selectionIndexPath = selectionViewSelectedIndexPath {
                if selectionIndexPath == indexPath {
                    cell.configureRemove(visible: true)
                } else {
                    cell.configureRemove(visible: false)
                }
            } else {
                cell.configureRemove(visible: false)
            }
            
            cell.delegate = self
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case self.collectionView:
            let length = (collectionView.frame.width) / itemsPerRow
            return CGSize(width: length, height: length)
        case selectionCollectionView:
            return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
        default:
            return .zero
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeaderReuseableView.identifier, for: indexPath) as! sectionHeaderReuseableView
            header.headerTitle.text = self.sections[indexPath.section]
            return header
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        switch collectionView {
        case self.collectionView:
            return CGSize(width: collectionView.frame.width, height: 42)
        default:
            return .zero
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
        case self.collectionView:
            
            if indexPath.section == 0 {
                if selectedWeathers.contains(Weathers[indexPath.item]) {
                    // remove
                    if let idx = selectedWeathers.firstIndex(of: Weathers[indexPath.item]) {
                        selectedWeathers.remove(at: idx)
                    }
                } else {
                    selectedWeathers.append(Weathers[indexPath.item])
                }
            } else if indexPath.section == 1 {
                if selectedMoods.contains(Moods[indexPath.item]) {
                    // remove
                    if let idx = selectedMoods.firstIndex(of: Moods[indexPath.item]) {
                        selectedMoods.remove(at: idx)
                    }
                } else {
                    selectedMoods.append(Moods[indexPath.item])
                }
            }
            
            if selectedIndexPaths.contains(indexPath) {
                if let idx = selectedIndexPaths.firstIndex(of: indexPath) {
                    selectedIndexPaths.remove(at: idx)
                }
            } else {
                selectedIndexPaths.append(indexPath)
                
            }
            
            collectionView.reloadData()
            
            
        case selectionCollectionView:

            print("selected indexPath: \(indexPath.item)")

            if let selectionIndexPath = self.selectionViewSelectedIndexPath {
                if selectionIndexPath == indexPath {
                    print("...setting SVIP -> nil")
                    self.selectionViewSelectedIndexPath = nil
                } else {
                    print("...setting SVIP -> \(indexPath.item)")
                    self.selectionViewSelectedIndexPath = indexPath
                }
            } else {
                print("...setting SVIP -> \(indexPath.item)")
                self.selectionViewSelectedIndexPath = indexPath
            }

            self.selectionCollectionView.reloadData()

        default:
            print("NOTHING TO DO")
        }
    }
    
    
    
    func resetViews() {
        self.imageSelected = false
        self.newOutfitImageButton.isSelected = false
        self.newOutfitImageButton.backgroundColor = blueColor
        self.nameTxtField.text = nil
        self.minTxtField.text = nil
        self.maxTxtField.text = nil
        self.selectionViewSelectedIndexPath = nil
        self.selectedIndexPaths.removeAll()
        self.selectedClothes.removeAll()
        self.collectionView.reloadData()
        self.selectionCollectionView.reloadData()
    }
    
    func saveNewOutfit(completion: (Bool, Outfit) -> Void) {
        if selectedClothes.count != 0 && imageSelected && nameTxtField.text != "" && minTxtField.text != "" && maxTxtField.text != "" {
            print("...save criteria met")
            guard let CDM = self.coreDataManager else { return }
            CDM.saveNewOutfit(name: nameTxtField.text!, minTemp: minTxtField.text!, maxTemp: maxTxtField.text!, clothes: selectedClothes, moods: selectedMoods, weathers: selectedWeathers) { (successful) in
                if successful {
                    print("...successfully saved outfit in CoreData")
                }
            }
        }
    }
    
    
    @IBAction func didTapImageButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            sender.backgroundColor = blueColor
        } else {
            sender.isSelected = true
            sender.backgroundColor = .green
        }
        
        imageSelected = !imageSelected
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "addClothingItemsSegue" {
            let dest = segue.destination as! AddClothingItemsViewController
            dest.selectedClothes = self.selectedClothes
            dest.clothingItems = self.clothingItems
            dest.ParentVC = self
//            dest.collectionView.reloadData()
        }
    }
    
    
    @IBAction func addClothingItemTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "addClothingItemsSegue", sender: self)
    }
    
    func remove() {
        guard let selectionIndexPath = self.selectionViewSelectedIndexPath else { return }
        print("REMOVE item at \(selectionIndexPath.item)")
        
        self.selectedClothes.remove(at: selectionIndexPath.item)
        self.selectionViewSelectedIndexPath = nil
        self.selectionCollectionView.reloadData()
        
        
    }
    

}

extension UIViewController {
    func categoryFor(section: Int) -> Category {
        let category = Categories[section]
        return category
    }
    
    func getItem(forIndexPath: IndexPath, clothingItems: [String: [Clothing]]) -> Clothing? {
        let sectionName = Categories[forIndexPath.section]
        if let sectionItems = clothingItems[sectionName.name] {
            let selectedItem = sectionItems[forIndexPath.item]
            return selectedItem
        } else {
            return nil
        }
    }
    
    func printOutfit(outfit: Outfit) {
        var counter = 0
        
        let outfitClothingItems = outfit.clothing as! Set<Clothing>
        print("-----------------------------------------------")
        print("--    OUTFIT : \(outfit.name!)    --")
        print()
        print("mood : \(outfit.mood!)")
        print()
        // Print clothing items for outfit
        print("--    Clothing Items     --")
        for item in outfitClothingItems {
            print("item: \(counter + 1)")
            printClothing(clothing: item, detailed: false)
            
            counter += 1
        }
        print("-----------------------------------------------")
    }
    
    func printClothing(clothing: Clothing, detailed: Bool) {
        print("\tname     : \(clothing.name!)")
        print("\tCategory : \(clothing.category!)")
        
        if detailed {
            print("\tminTemp  : \(clothing.minTemp!)")
            print("\tmaxTemp  : \(clothing.maxTemp!)")
            
            print("\tmoods    : \(clothing.mood!)")
            print("\tweather  : \(clothing.weather!)")
            print("\timage    : \(clothing.image!)")
        }
        print()
    }
}
