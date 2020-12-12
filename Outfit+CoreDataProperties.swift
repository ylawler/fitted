//
//  Outfit+CoreDataProperties.swift
//  fitted
//
//  Created by Yannick Lawler on 03.12.20.
//
//

import Foundation
import CoreData


extension Outfit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Outfit> {
        return NSFetchRequest<Outfit>(entityName: "Outfit")
    }

    @NSManaged public var id: String?
    @NSManaged public var mood: String?
    @NSManaged public var name: String?
    @NSManaged public var weather: String?
    @NSManaged public var minTemp: String?
    @NSManaged public var maxTemp: String?
    @NSManaged public var clothing: NSSet?

}

// MARK: Generated accessors for clothing
extension Outfit {

    @objc(addClothingObject:)
    @NSManaged public func addToClothing(_ value: Clothing)

    @objc(removeClothingObject:)
    @NSManaged public func removeFromClothing(_ value: Clothing)

    @objc(addClothing:)
    @NSManaged public func addToClothing(_ values: NSSet)

    @objc(removeClothing:)
    @NSManaged public func removeFromClothing(_ values: NSSet)

}

extension Outfit : Identifiable {

}
