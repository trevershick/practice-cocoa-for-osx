//
//  AppDelegate.swift
//  RanchForecast
//
//  Created by Trever Shick on 11/19/16.
//  Copyright © 2016 Trever Shick. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var mainWindowController : MainWindowController!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let mc = MainWindowController()
        mc.showWindow(self)
        self.mainWindowController = mc
    }



}

