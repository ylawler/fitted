//
//  CreateViewController.swift
//  fitted
//
//  Created by Yannick Lawler on 23.11.20.
//

import UIKit

class CreateViewController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var outfitContainerView: UIView!
    @IBOutlet weak var clothingItemContainerView: UIView!
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var createOutfitController: CreateOutfitContainerViewController?
    var createClothingController: CreateClothingItemContainerViewController?
    
    
    var Clothes: [String: [Clothing]] = [:]
    
    let coreDataManager = CoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Load clothing items from coredata
        
        coreDataManager.loadClothing(completion: { (successful, Clothing) in
            self.Clothes = Clothing
            self.updateContainerView(containerView: "Outfit")
            self.updateContainerView(containerView: "Clothing")
        })
        

        // Do any additional setup after loading the view.
        self.setCreationTo(idx: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "outfitCreationSegue" {
            let dest = segue.destination as! CreateOutfitContainerViewController
            dest.clothingItems = self.Clothes
            self.createOutfitController = dest
            dest.coreDataManager = self.coreDataManager
        } else if segue.identifier == "clothingItemSegue" {
            let dest = segue.destination as! CreateClothingItemContainerViewController
            self.createClothingController = dest
            dest.coreDataManager = self.coreDataManager
        }
    }
    
    func setCreationTo(idx: Int) {
        if idx == 0 {
            displayOutfitCreation()
        } else {
            displayClothingItemCreation()
        }
    }
    
    func displayOutfitCreation() {
        UIView.animate(withDuration: 0.5) {
            self.outfitContainerView.isHidden = false
            self.clothingItemContainerView.isHidden = true
        }
    }
    
    func displayClothingItemCreation() {
        UIView.animate(withDuration: 0.5) {
            self.outfitContainerView.isHidden = true
            self.clothingItemContainerView.isHidden = false
        }
    }
    
    @IBAction func segmentTapped(_ sender: UISegmentedControl) {
        self.setCreationTo(idx: sender.selectedSegmentIndex)
    }

    @IBAction func resetButtonTapped(_ sender: UIButton) {
        print("RESET")
        
        
        if segmentControl.selectedSegmentIndex == 0 {
            // clear the selectedIndexPaths and reload collectionViewData
            guard let outfitVC = self.createOutfitController else { return }
            outfitVC.resetViews()
        } else {
            guard let clothingVC = self.createClothingController else { return }
            clothingVC.resetViews()
        }
    }
    
    func updateContainerView(containerView: String) {
        if containerView == "Outfit" {
            // update Outfit container view
            guard let containerOutfit = self.createOutfitController else { return }
            containerOutfit.update(Clothes: self.Clothes)
        } else if containerView.self == "Clothing" {
//            guard let containerClothing = self.createClothingController else { return }
            guard let containerOutfit = self.createOutfitController else { return }
            containerOutfit.update(Clothes: self.Clothes)
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            print("-----------------------------------------------------")
            print("Saving New Outfit")
            guard let outfitVC = self.createOutfitController else { return }
            print("...outfitVC created")
            outfitVC.saveNewOutfit { (successful, outfit) in
                if successful {
                    print("*** SUCCESSFUL SAVING NEW OUTFIT ***")
                }
            }
        case 1:
            print("-----------------------------------------------------")
            print("Saving New CLothing")
            guard let clothingVC = self.createClothingController else { return }
            print("clothingVC created")
            clothingVC.saveNewClothing { (successful, clothing) in
                if successful {
                    self.Clothes.updateValue([clothing], forKey: clothing.category!)
                    self.updateContainerView(containerView: "Clothing")
                }
            }
        default:
            print("ERROR -> SAving Clothing/Outfit")
        }
        
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
