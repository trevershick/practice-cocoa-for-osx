//
//  HostsModel.swift
//  usotsuki
//
//  Created by Trever Shick on 12/4/16.
//  Copyright © 2016 Trever Shick. All rights reserved.
//

import Cocoa

class HostsModel {

    let managedObjectContext: NSManagedObjectContext

    let _local = Grouping(name: "Local")
    let _remote = Grouping(name: "Remote")
    let _combined = Grouping(name: "Combined")

    
    init(_ managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    func entriesCount(in grouping : Grouping) -> Int {
        if grouping === _local {
            return localCount()
        }
        return 0
    }
    func entries(in grouping: Grouping) -> [Entry] {
        if grouping === _local {
            return localEntries()
        }
        return []
    }
    
    func grouping(at index: Int) -> Grouping {
        switch index {
        case 0:
            return _local
        case 1:
            return _remote
        default:
            return _combined
        }
    }
    
    func groupings() -> [Grouping] {
        return [_local,_remote,_combined]
    }
    
    func localEntries() -> [LocalEntry] {
        let f = NSFetchRequest<LocalEntry>(entityName: "LocalEntry")
        do {
            let fetched = try managedObjectContext.fetch(f)
            return fetched
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
    func localCount() -> Int {
        do {
            let i = try managedObjectContext.count(for: NSFetchRequest<LocalEntry>(entityName: "LocalEntry"))
            return i
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
}
