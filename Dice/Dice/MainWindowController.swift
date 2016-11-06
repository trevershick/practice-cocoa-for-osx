//
//  MainWindowController.swift
//  Dice
//
//  Created by Trever Shick on 10/17/16.
//  Copyright © 2016 Trever Shick. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {


    @IBOutlet weak var die2: DieView!
    
    
    override var windowNibName: String? {
        return "MainWindowController"
    }


    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    var preferenceWindowController : PreferenceWindowController?
    
    @IBAction func showDieConfiguration(_ sender : AnyObject?) {
        
        if let window = window,
            let dieView = window.firstResponder as? DieView {
            
            let windowController = PreferenceWindowController()
            
            windowController.configuration = DieConfiguration(dieView.color,
                                                              dieView.numberOfTimesToRoll)
            
            window.beginSheet(windowController.window!, completionHandler: { response in
                if response == NSModalResponseOK {
                    let c : DieConfiguration = self.preferenceWindowController!.configuration
                    dieView.color = c.color
                    dieView.numberOfTimesToRoll = c.rolls
                }
                self.preferenceWindowController = nil
            })
            self.preferenceWindowController = windowController
            
        }
    }
    
}
