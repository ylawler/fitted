//
//  Clothing+CoreDataProperties.swift
//  fitted
//
//  Created by Yannick Lawler on 03.12.20.
//
//

import Foundation
import CoreData


extension Clothing {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Clothing> {
        return NSFetchRequest<Clothing>(entityName: "Clothing")
    }

    @NSManaged public var category: String?
    @NSManaged public var id: String?
    @NSManaged public var image: Data?
    @NSManaged public var maxTemp: String?
    @NSManaged public var minTemp: String?
    @NSManaged public var mood: String?
    @NSManaged public var name: String?
    @NSManaged public var weather: String?
    @NSManaged public var outfits: NSSet?

}

// MARK: Generated accessors for outfits
extension Clothing {

    @objc(addOutfitsObject:)
    @NSManaged public func addToOutfits(_ value: Outfit)

    @objc(removeOutfitsObject:)
    @NSManaged public func removeFromOutfits(_ value: Outfit)

    @objc(addOutfits:)
    @NSManaged public func addToOutfits(_ values: NSSet)

    @objc(removeOutfits:)
    @NSManaged public func removeFromOutfits(_ values: NSSet)

}

extension Clothing : Identifiable {

}
