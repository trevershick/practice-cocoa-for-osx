//
//  Document.swift
//  CarLot
//
//  Created by Trever Shick on 10/15/16.
//  Copyright © 2016 Trever Shick. All rights reserved.
//

import Cocoa

class Document: NSPersistentDocument {

    @IBOutlet weak var carController : CarArrayController!
    @IBOutlet weak var tableView : NSTableView!
    
    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }

    
    
    
    @IBAction func addCar(_ sender: NSButton) {
//        let windowController = windowControllers[0]
//        let window = windowController.window!
        
        
        // end the editing session if there is one.  This feels like
        // a hack but maybe it's standard...
        // i'm going to leave this commented out because maybe it's not
        // truly needed?
        //        let endedEditing = window.makeFirstResponder(window)
        //        if !endedEditing {
        //            NSLog("Unable to end editing")
        //            return
        //        }
        
        if let gl = undoManager?.groupingLevel,
            gl > 0 {
            undoManager?.endUndoGrouping()
            undoManager?.beginUndoGrouping()
        }
        
        let employee : NSObject = carController.newObject() as! NSObject
        carController.addObject(employee)
        carController.rearrangeObjects()
        
        let sortedEmployees = carController.arrangedObjects as! [NSObject]
        
        if let row = sortedEmployees.index(of: employee) {
            tableView.editColumn(0, row: row, with: nil, select: true)
        }
    }
    
    
    
    override class func autosavesInPlace() -> Bool {
        return true
    }
    
    override var windowNibName: String? {
        // Returns the nib file name of the document
        // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this property and override -makeWindowControllers instead.
        return "Document"
    }

}
