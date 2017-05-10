//
//  CombinedEntry.swift
//  usotsuki
//
//  Created by Trever Shick on 12/3/16.
//  Copyright © 2016 Trever Shick. All rights reserved.
//

import Cocoa

class CombinedEntry: Entry {
    @NSManaged var includes: Set<Entry>?
}
