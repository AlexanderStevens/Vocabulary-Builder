//
//  Word+CoreDataProperties.swift
//  Vocabulary Builder
//
//  Created by AlexS on 01/08/2016.
//  Copyright © 2016 AStevensProductions. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Word {

    @NSManaged var word: String?
    @NSManaged var photoData: NSData?
    @NSManaged var wordDescription: String?
    @NSManaged var dateAdded: NSDate?
    @NSManaged var imageName: String?

}
