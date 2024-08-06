//
//  Walk+CoreDataProperties.swift
//  DogWalk
//
//  Created by Mykola Zhurba on 06/08/2024.
//  Copyright © 2024 Razeware. All rights reserved.
//
//

import Foundation
import CoreData


extension Walk {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Walk> {
        return NSFetchRequest<Walk>(entityName: "Walk")
    }

    @NSManaged public var date: Date?
    @NSManaged public var dog: Dog?

}

extension Walk : Identifiable {

}
