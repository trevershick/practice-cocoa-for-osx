//
//  AppDelegate.swift
//  Dice
//
//  Created by Trever Shick on 10/17/16.
//  Copyright © 2016 Trever Shick. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    var mainWindowController : MainWindowController!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let mc = MainWindowController()
        mc.showWindow(self)
        self.mainWindowController = mc
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

