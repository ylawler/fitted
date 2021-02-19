//
//  CreateClothingItemContainerViewController.swift
//  fitted
//
//  Created by Yannick Lawler on 23.11.20.
//

import UIKit

class CreateClothingItemContainerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
//    @IBOutlet weak var collectionView: UICollectionView!

    
    @IBOutlet weak var createImageButton: UIButton!
    
    @IBOutlet weak var nameTxtField: UITextField!
    
    @IBOutlet weak var minTxtField: UITextField!
    @IBOutlet weak var maxTxtField: UITextField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var createCategory: fittedCategory?
    
   
    
    let sections = ["Weather", "Mood", "Categories"]
    
    
    var selectedIndexPaths: [IndexPath] = []
    var selectedWeathers: [fittedWeather] = []
    var selectedMoods: [fittedMood] = []
//    var selectedCategory: String = ""
    var imageSelected: Bool = false
    
    var coreDataManager: CoreDataManager?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.createImageButton.layer.cornerRadius = 12
        self.createImageButton.backgroundColor = blueColor
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.alwaysBounceVertical = true
        
        self.collectionView.register(WeatherCollectionViewCell.nib(), forCellWithReuseIdentifier: WeatherCollectionViewCell.identifier)
        self.collectionView.register(MoodCollectionViewCell.nib(), forCellWithReuseIdentifier: MoodCollectionViewCell.identifier)
        self.collectionView.register(CategoryCollectionViewCell.nib(), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        self.collectionView.register(sectionHeaderReuseableView.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderReuseableView.identifier)
        
        self.hideKeyboardWhenTappedAround()
        // What is the data we want
        /*
         image
         name
         min and max temp
         weather
         mood
         
         
         */
        
        
    }
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            // Weather
            return fittedWeathers.count
        case 1:
            // Mood
            return fittedMoods.count
        case 2:
            return fittedCategories.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as! WeatherCollectionViewCell
            
            if selectedIndexPaths.contains(indexPath) {
                cell.weatherBackground.backgroundColor = .green
            } else {
                cell.weatherBackground.backgroundColor = blueColor
            }
            
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoodCollectionViewCell.identifier, for: indexPath) as! MoodCollectionViewCell
            
            if selectedIndexPaths.contains(indexPath) {
                cell.moodBackground.backgroundColor = .green
            } else {
                cell.moodBackground.backgroundColor = blueColor
            }
            
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
            let category = categoryFor(section: indexPath.item)
            
            if createCategory != nil && createCategory?.name == category.name {
                cell.categoryBackground.backgroundColor = .green
            } else {
                cell.categoryBackground.backgroundColor = blueColor
            }
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 4
        let length = collectionView.frame.width / itemsPerRow
        
        return CGSize(width: length, height: length)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
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
        return CGSize(width: collectionView.frame.width, height: 42)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            if selectedWeathers.contains(fittedWeathers[indexPath.item]) {
                // remove
                if let idx = selectedWeathers.firstIndex(of: fittedWeathers[indexPath.item]) {
                    selectedWeathers.remove(at: idx)
                }
            } else {
                selectedWeathers.append(fittedWeathers[indexPath.item])
            }
        } else if indexPath.section == 1 {
            if selectedMoods.contains(fittedMoods[indexPath.item]) {
                // remove
                if let idx = selectedMoods.firstIndex(of: fittedMoods[indexPath.item]) {
                    selectedMoods.remove(at: idx)
                }
            } else {
                selectedMoods.append(fittedMoods[indexPath.item])
            }
        } else if indexPath.section == 2 {
            if createCategory == fittedCategories[indexPath.item] {
                // remove
                createCategory = nil
            } else {
                createCategory = fittedCategories[indexPath.item]
            }
        }
        if indexPath.section != 2 {
            if selectedIndexPaths.contains(indexPath) {
                if let idx = selectedIndexPaths.firstIndex(of: indexPath) {
                    selectedIndexPaths.remove(at: idx)
                }
            } else {
                selectedIndexPaths.append(indexPath)
                
            }
        }
        self.collectionView.reloadData()
    }
    
    func resetViews() {
        self.createImageButton.isSelected = false
        self.createImageButton.backgroundColor = blueColor
        self.imageSelected = false
        
        self.nameTxtField.text = nil
        self.minTxtField.text = nil
        self.maxTxtField.text = nil
        self.createCategory = nil
        
        
        self.selectedMoods.removeAll()
        self.selectedWeathers.removeAll()
        self.selectedIndexPaths.removeAll()
        self.collectionView.reloadData()
    }
    
    func saveNewClothing(completion: (Bool, Clothing) -> Void) {
        
        if nameTxtField.text != "" && minTxtField.text != "" && maxTxtField.text != "" && selectedMoods != [] && selectedWeathers != [] && imageSelected && createCategory != nil {
            
            print("...save criteria met")
            
            guard let CDM = self.coreDataManager else { return }
            
            print("...we have a CDM")
            
            CDM.saveNewClothing(name: nameTxtField.text!, minTemp: minTxtField.text!, maxTemp: maxTxtField.text!, moods: selectedMoods, weathers: selectedWeathers, img: UIImage(systemName: "person")!, category: createCategory!) { (successful, clothing) in
                
                if successful {
                    print("...saving to coreData: successul")
                    printClothing(clothing: clothing!, detailed: true)
                    self.resetViews()
                    completion(true, clothing!)
                } else {
                    print("...saving to coreData: failed")
                }
            }
        } else {
            print("...save criteria not met")
            print("...failed SaveNewClothing: CreateClothingContainerViewController")
            
            
            
            //TODO: Display alert message unable to save new clothing
            /*
                - fill in missing parts
                - reset page
                
             */
            self.resetViews()
        }
        
    }
    
    

    @IBAction func createImageTapped(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            sender.backgroundColor = blueColor
        } else {
            sender.isSelected = true
            sender.backgroundColor = .green
        }
        
        imageSelected = !imageSelected
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
