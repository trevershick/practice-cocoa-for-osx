//
//  MainWindowController.swift
//  Thermostat
//
//  Created by Trever Shick on 10/13/16.
//  Copyright © 2016 Trever Shick. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    dynamic var temperature = 68
    
    
    override var windowNibName: String? {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    @IBAction func warmer(_ sender: AnyObject) {
        temperature += 1
//        if let t = self.value(forKey: "temperature") as? Int {
//            self.setValue(t+1, forKey: "temperature")
//        }
    }
    
    @IBAction func cooler(_ sender: AnyObject) {
        if let t = self.value(forKey: "temperature") as? Int {
            self.setValue(t-1, forKey: "temperature")
        }
        
    }
}
