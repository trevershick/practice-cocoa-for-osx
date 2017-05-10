//
//  RemoteEntry.swift
//  usotsuki
//
//  Created by Trever Shick on 12/3/16.
//  Copyright © 2016 Trever Shick. All rights reserved.
//

import Cocoa

class RemoteEntry: Entry {
    @NSManaged var lastAttempt: Date?
    @NSManaged var lastUpdated: Date?
    @NSManaged var lastError: String?

    @NSManaged var updateIntervalMinutes: Int16
    @NSManaged var url: String?
}
