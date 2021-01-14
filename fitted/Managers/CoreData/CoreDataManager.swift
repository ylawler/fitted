//
//  CoreDataManager.swift
//  fitted
//
//  Created by Yannick Lawler on 25.11.20.
//

import UIKit
import CoreData

class CoreDataManager {

    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveNewOutfit(name: String, minTemp: String, maxTemp: String, clothes: [Clothing], moods: [Mood], weathers: [Weather], completion: (Bool) -> Void) {
        print("...save outfit into coreData")
        
        let newOutfit = Outfit(context: self.context)
        newOutfit.id = UUID().uuidString
        
        for clothing in clothes {
            newOutfit.addToClothing(clothing)
        }
        
        newOutfit.mood = expandMoods(array: moods)
        newOutfit.weather = expandWeathers(array: weathers)
        newOutfit.name = name
        newOutfit.minTemp = minTemp
        newOutfit.maxTemp = maxTemp
        
        
        
        
        do {
            try self.context.save()
            completion(true)
        } catch let err {
            print("Error saving new Outfit: \(err)")
            completion(false)
        }
    }
    
    func loadClothing(completion: (Bool, [String: [Clothing]]) -> Void)  {
        
        var result: [String: [Clothing]] = [:]
        
        do {
            let clothes = try context.fetch(Clothing.fetchRequest()) as! [Clothing]
            
           
            for clothing in clothes {
                
                if var clothesForCategory = result[clothing.category!] {
                    clothesForCategory.append(clothing)
                    result.updateValue(clothesForCategory, forKey: clothing.category!)
                } else {
                    result.updateValue([clothing], forKey: clothing.category!)
                }
                
                
            }
            
            
            print("loaded clothes: \(clothes)")
            completion(true, result)
            
            
        } catch let err {
            completion(false, result)
            print(err)
        }
    }
    
    func loadOutfits(completion: (Bool, [Outfit]) -> Void)  {
        
        var outfits: [Outfit] = []
        
        do {
            outfits = try context.fetch(Outfit.fetchRequest()) as! [Outfit]
            
            print("loaded outfits: \(outfits)")
            completion(true, outfits)
            
        } catch let err {
            completion(false, outfits)
            print(err)
        }
    }
    
    

    func saveNewClothing(name: String, minTemp: String, maxTemp: String, moods: [Mood], weathers: [Weather], img: UIImage, category: Category, completion: (Bool, Clothing?) -> Void) {
        print("...save clothing into coreData")
        
        let newClothing = Clothing(context: self.context)
        newClothing.id = UUID().uuidString
        newClothing.minTemp = minTemp
        newClothing.maxTemp = maxTemp
        newClothing.name = name
        newClothing.image = img.pngData()
        newClothing.category = category.name
        // split mood array into one string
        newClothing.mood = expandMoods(array: moods)

        // split weather array into one string
        newClothing.weather = expandWeathers(array: weathers)
        
        do {
            try self.context.save()
            completion(true, newClothing)
        } catch let err {
            print("Error saving new Clothing: \(err)")
        }
    }
    
    func expandMoods(array: [Mood]) -> String {
        var res = ""
        for mood in array {
            if mood == array.last {
                res += "\(mood.name)"
            } else {
                res += "\(mood.name),"
            }
        }
        return res
    }
    
    func expandWeathers(array: [Weather]) -> String {
        var res = ""
        for weather in array {
            if weather == array.last {
                res += "\(weather.name)"
            } else {
                res += "\(weather.name),"
            }
        }
        return res
    }

    func itemExists(id: String, entityName: String) -> Bool {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "\(entityName)")
        let filter = NSPredicate(format: "id CONTAINS '\(id)'")
        request.predicate = filter
        do {

            var fetchResults: [AnyObject] = []

            if entityName == "Outfit" {
                fetchResults = try self.context.fetch(request) as! [Outfit]
            } else if entityName == "Clothing" {
                fetchResults = try self.context.fetch(request) as! [Clothing]
            }

            print(fetchResults)

            for result in fetchResults {
                print("Checking resultId: \(String(describing: result.id)) == \(id)")
                if result.id == id {
                    // Player exists
                    return true
                }
            }

            return false

        } catch let err {
            print(err)
            return false
        }

    }

    
}
