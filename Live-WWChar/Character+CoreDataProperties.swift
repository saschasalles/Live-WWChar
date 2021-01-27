//
//  Character+CoreDataProperties.swift
//  Live-WWChar
//
//  Created by Sascha Sallès on 27/01/2021.
//
//

import Foundation
import CoreData


extension Character {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Character> {
        return NSFetchRequest<Character>(entityName: "Character")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var age: Int64
    @NSManaged public var id: UUID?
    @NSManaged public var house: House?

}

extension Character : Identifiable {

}
