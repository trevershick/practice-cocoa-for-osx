//
//  Entry.swift
//  usotsuki
//
//  Created by Trever Shick on 12/3/16.
//  Copyright © 2016 Trever Shick. All rights reserved.
//
import Foundation
import CoreData

class Entry: NSManagedObject {
    @NSManaged var viewInMenu: Bool
    @NSManaged var name: String
    @NSManaged var content: String?
    @NSManaged var usedBy: Set<CombinedEntry>?
}
