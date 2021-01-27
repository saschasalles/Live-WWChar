//
//  House+CoreDataProperties.swift
//  Live-WWChar
//
//  Created by Sascha Sallès on 27/01/2021.
//
//

import Foundation
import CoreData


extension House {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<House> {
        return NSFetchRequest<House>(entityName: "House")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var characters: NSSet?

}

// MARK: Generated accessors for characters
extension House {

    @objc(addCharactersObject:)
    @NSManaged public func addToCharacters(_ value: Character)

    @objc(removeCharactersObject:)
    @NSManaged public func removeFromCharacters(_ value: Character)

    @objc(addCharacters:)
    @NSManaged public func addToCharacters(_ values: NSSet)

    @objc(removeCharacters:)
    @NSManaged public func removeFromCharacters(_ values: NSSet)

}

extension House : Identifiable {

}
