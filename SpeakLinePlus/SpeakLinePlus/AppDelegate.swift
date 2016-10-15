//
//  AppDelegate.swift
//  SpeakLinePlus
//
//  Created by Trever Shick on 10/13/16.
//  Copyright © 2016 Trever Shick. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    var c : MainWindowController?


    func applicationDidFinishLaunching(_ aNotification: Notification) {

        let mc = MainWindowController()
        mc.showWindow(self)
        self.c = mc
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

