//
//  Attendance+CoreDataProperties.swift
//  CoreDataCRUD
//
//  Created by Yoel Lev on 7/3/17.
//  Copyright © 2017 YoelL. All rights reserved.
//
//

import Foundation
import CoreData


extension Attendance {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Attendance> {
        return NSFetchRequest<Attendance>(entityName: "Attendance")
    }

    @NSManaged public var studentId: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var enter: Bool
    @NSManaged public var exit: Bool
    @NSManaged public var location: String?

}
