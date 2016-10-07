//
//  Employee+CoreDataProperties.swift
//  CoreDataSw
//
//  Created by Qinting on 16/5/9.
//  Copyright © 2016年 Qinting. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Employee {

    @NSManaged var age: NSNumber?
    @NSManaged var name: String?

}
