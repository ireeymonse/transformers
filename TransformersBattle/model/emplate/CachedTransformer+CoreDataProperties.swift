//
//  CachedTransformer+CoreDataProperties.swift
//  
//
//  Created by Iree Garcia on 9/28/20.
//
//

import Foundation
import CoreData


extension CachedTransformer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedTransformer> {
        return NSFetchRequest<CachedTransformer>(entityName: "CachedTransformer")
    }

    @NSManaged public var courage: Int16
    @NSManaged public var endurance: Int16
    @NSManaged public var firepower: Int16
    @NSManaged public var id: String?
    @NSManaged public var intelligence: Int16
    @NSManaged public var name: String?
    @NSManaged public var rank: Int16
    @NSManaged public var skill: Int16
    @NSManaged public var speed: Int16
    @NSManaged public var strength: Int16
    @NSManaged public var team: String?

}
