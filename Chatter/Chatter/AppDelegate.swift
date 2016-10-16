//
//  AppDelegate.swift
//  Chatter
//
//  Created by Trever Shick on 10/16/16.
//  Copyright © 2016 Trever Shick. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var windowControllers : [ChatWindowController] = []

    @IBAction func onFileNew(_ sender: AnyObject) {
        newWindow()
    }

    func newWindow() {
        let cw = ChatWindowController()
        cw.showWindow(self)
        windowControllers.append(cw)
    }
    
    func applicationDidResignActive(_ notification: Notification) {
        NSLog("ApplicationDidResignActive")
        NSBeep()
        NSBeep()
    }
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
//        let mc = MainWindowController()
//        mc.showWindow(self)
//        self.mainWindowController = mc
        newWindow()
    }

    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

