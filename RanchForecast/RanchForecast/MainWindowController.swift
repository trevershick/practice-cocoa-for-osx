//
//  MainWindowController.swift
//  RanchForecast
//
//  Created by Trever Shick on 11/19/16.
//  Copyright © 2016 Trever Shick. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    
    @IBOutlet var courses: NSArrayController!
    
    
    override var windowNibName: String? {
        return "MainWindowController"
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
}
