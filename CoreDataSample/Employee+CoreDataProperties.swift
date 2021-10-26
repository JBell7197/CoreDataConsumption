//
//  Employee+CoreDataProperties.swift
//  CoreDataSample
//
//  Created by Justin Bell on 10/26/21.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var address: String?
    @NSManaged public var name: String?

}

extension Employee : Identifiable {

}
