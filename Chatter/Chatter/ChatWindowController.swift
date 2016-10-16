//
//  ChatWindowController.swift
//  Chatter
//
//  Created by Trever Shick on 10/16/16.
//  Copyright © 2016 Trever Shick. All rights reserved.
//

import Cocoa

class ChatWindowController: NSWindowController {

    private let CHAT_MESSAGE = Notification.Name("ChatMessageNotification")
    private let MESSAGE_KEY = "Mkey"
    
    
    dynamic var log : NSAttributedString = NSAttributedString(string: "")
    dynamic var message : String?
    
    private let nc = NotificationCenter.default
    @IBOutlet weak var textView: NSTextFieldCell!
    
    @IBAction func onSend(_ sender: AnyObject) {
        window?.makeFirstResponder(nil)
        if message != nil {
            nc.post(name: CHAT_MESSAGE,
                    object: self,
                    userInfo: [MESSAGE_KEY : message])
        }
        self.setValue(nil, forKey: "message")
    }
    
    deinit {
        NSLog("Removing self as observer")
        nc.removeObserver(self)
    }
    
    override var windowNibName: String? {
        return "ChatWindowController"
    }
    
    
    override func windowDidLoad() {
        super.windowDidLoad()
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        nc.addObserver(self, selector: #selector(onChatMessage(with:)),
                       name: CHAT_MESSAGE,
                       object: nil)
        textView.focusRingType = .none
    }
    
    func onChatMessage(with notification:NSNotification) {
        NSLog("onChatMessage value = \(notification)")
        
        if !self.isEqual(notification.object),
            let msg = notification.userInfo?[MESSAGE_KEY] as? String,
            let mutableLog = log.mutableCopy() as? NSMutableAttributedString {
            
            mutableLog.append(NSAttributedString(string: msg))
            mutableLog.append(NSAttributedString(string: "\n"))
            
            log = mutableLog.copy() as! NSAttributedString
        }
    }
}
