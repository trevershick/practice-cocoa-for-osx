//
//  PreferenceWindowController.swift
//  Dice
//
//  Created by Trever Shick on 11/6/16.
//  Copyright © 2016 Trever Shick. All rights reserved.
//

import Cocoa

struct DieConfiguration {
    let color : NSColor
    let rolls : Int
    
    init(_ color : NSColor, _ rolls : Int) {
        self.color = color
        self.rolls = max(rolls, 1)
    }
}

class PreferenceWindowController: NSWindowController {

    private dynamic var color : NSColor = NSColor.white
    private dynamic var rolls : Int = 10
    
    var configuration : DieConfiguration {
        set {
            color = newValue.color
            rolls = newValue.rolls
        }
        get {
            return DieConfiguration(color,rolls)
        }
    }
    override var windowNibName: String? {
        return "PreferenceWindowController"
    }

    
    @IBAction func onOkay(_ button: NSButton) {
        window?.endEditing(for: nil)
        dismissWithModalResponse(response: NSModalResponseOK)
    }
    
    @IBAction func onCancel(_ button: NSButton) {
        window?.endEditing(for: nil)
        dismissWithModalResponse(response: NSModalResponseCancel)
    }
    
    func dismissWithModalResponse(response: NSModalResponse) {
        window!.sheetParent!.endSheet(window!, returnCode: response)
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
}
