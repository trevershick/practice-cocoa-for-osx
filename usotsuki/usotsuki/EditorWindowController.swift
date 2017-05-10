//
//  EditorWindowController.swift
//  usotsuki
//
//  Created by Trever Shick on 12/3/16.
//  Copyright © 2016 Trever Shick. All rights reserved.
//

import Cocoa

class EditorWindowController: NSWindowController, NSWindowDelegate, NSOutlineViewDataSource, NSOutlineViewDelegate {
    
    @IBOutlet var arrayController: NSArrayController!
    @IBOutlet var sourceList : NSOutlineView!
    var hostsModel : HostsModel?
    
    // this is set after creation
    dynamic var managedObjectContext: NSManagedObjectContext?
    
    
    init(hostsModel: HostsModel) {
        self.hostsModel = hostsModel
        super.init(window: nil)
    }
    
    
//    public init(window: NSWindow?)
//    
//    public init?(coder: NSCoder)

    init()  {
        super.init(window: nil)
    }
    
    override init(window: NSWindow?) {
        super.init(window: window)
        // Initialization code here.
    }

    required init?(coder: NSCoder) {
        super.init(window:nil)
    }

    
    func show() {
        self.window?.setIsVisible(true)
    }
    
    override func close() {
        hide()
    }
    
    func hide() {
        self.window?.setIsVisible(false)
    }
    
    override var windowNibName: String? {
        return "EditorWindowController"
    }
    
    

    
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if item == nil {
            return hostsModel?.grouping(at: index) as Any
        }
        return "x"
    }
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if item == nil {
            return hostsModel?.groupings().count ?? 0
        }
        if let g = item as? Grouping {
            return hostsModel?.entriesCount(in: g) ?? 0
        }
        
        return 0
    }

    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        switch item {
        case let g as Grouping:
            let view = outlineView.make(withIdentifier: "HeaderCell", owner: self) as! NSTableCellView
            view.textField?.stringValue = g.name
            return view
        case let e as Entry:
            let view = outlineView.make(withIdentifier: "DataCell", owner: self) as! NSTableCellView
            view.textField?.stringValue = e.name
            return view
////        case let account as Account:
////            let view = outlineView.makeViewWithIdentifier("DataCell", owner: self) as NSTableCellView
////            if let textField = view.textField {
////                textField.stringValue = account.name
////            }
////            if let image = account.icon {
////                view.imageView!.image = image
////            }
////            return view
////        case let employee as Employee:
////            let view = outlineView.makeViewWithIdentifier("DataCell", owner: self) as NSTableCellView
////            if let textField = view.textField {
////                textField.stringValue = employee.firstName + " " + employee.lastName
////            }
////            if let image = employee.icon {
////                view.imageView!.image = image
////            }
////            return view
        default:
            let view = outlineView.make(withIdentifier: "DataCell", owner: self) as! NSTableCellView
            view.textField?.stringValue = "x"
            return view
        }
//
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        if let x = item as? Grouping {
            return true
        }
        return false
    }
    
    func outlineView(_ outlineView: NSOutlineView, isGroupItem item: Any) -> Bool {
        switch item {
            case let _ as Grouping:
                return true
            default:
                return false
        
        }
//        switch item {
//        case let _ as Type:
//            return true
//        default:
//            return false
//        }
//
    }
    
    
    
    override func windowDidLoad() {
        super.windowDidLoad()
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        self.window?.delegate = self
    }
    

}
