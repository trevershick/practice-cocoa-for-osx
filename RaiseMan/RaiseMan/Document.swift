
import Cocoa

private var KVOContext : Int = 0

class Document: NSDocument, NSWindowDelegate {

    
    @IBOutlet weak var arrayController : NSArrayController!
    @IBOutlet weak var tableView : NSTableView!
    
    
    dynamic var employees : [Employee] = [] {
        willSet {
            NSLog("Remove all bindings.")
            employees.forEach(self.stopObserving)
        }
        didSet {
            NSLog("Reobserve all \(employees)")
            employees.forEach(self.startObserving)
        }
    }
    
    
    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }
    
    
    @IBAction func addEmployee(_ sender: NSButton) {
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
        
        let employee = arrayController.newObject() as! Employee
        arrayController.addObject(employee)
        arrayController.rearrangeObjects()
        
        let sortedEmployees = arrayController.arrangedObjects as! [Employee]
        
        if let row = sortedEmployees.index(of: employee) {
            tableView.editColumn(0, row: row, with: nil, select: true)
        }
    }
    
    @IBAction func zeroify(sender : NSButton) {
        let selectedPeople : [Employee] = arrayController.selectedObjects as! [Employee]

        
        undoManager?.registerUndo(withTarget: self, handler:  {  (Document) -> () in
            let oldValues : [Float] = selectedPeople.map({$0.raise})
            for idx in 0..<oldValues.count {
                selectedPeople[idx].setValue(oldValues[idx], forKey: "raise")
            }
        })
        if undoManager?.isUndoing == false {
            undoManager?.setActionName("Zero Out Raises for \(selectedPeople.count) employees.")
        }
        selectedPeople.forEach({$0.setValue(0.0, forKey: "raise")})
    }

    @IBAction func removeEmployees(_ sender : AnyObject?) {
        let selectedPeople : [Employee] = arrayController.selectedObjects as! [Employee]
        
        let alert = NSAlert()
        alert.messageText = "Do you really want to delete these people?"
        alert.informativeText = "\(selectedPeople.count) will be deleted."
        alert.addButton(withTitle: "Remove")
        alert.addButton(withTitle: "Cancel")
        
        
        if let window = self.windowControllers.first?.window {
        
            alert.beginSheetModal(for: window, completionHandler: { (response) -> Void in
                if response == NSAlertFirstButtonReturn {
                    self.arrayController.remove(contentsOf: selectedPeople)
                }
            })
        }
    }
    
    
    // ---------------------------------
    // called by KVO subsystem
    
    func insertObject(_ employee: Employee, inEmployeesAtIndex: Int) {
        

        undoManager?.registerUndo(withTarget: self, handler:  {  (Document) -> (Void) in
            self.removeObjectFromEmployeesAtIndex(inEmployeesAtIndex)
        })
        if !undoManager!.isUndoing {
            undoManager?.setActionName("Add Person")
        }
        employees.append(employee)
    }
    
    
    func removeObjectFromEmployeesAtIndex(_ index : Int) {
        let undo : UndoManager = undoManager!
        
        let employee = employees[index]

        undoManager?.registerUndo(withTarget: self, handler:  {  (Document) -> () in
            self.insertObject(employee, inEmployeesAtIndex: index)
        })

        if !undo.isUndoing {
            undo.setActionName("Remove Person")
        }
        
        employees.remove(at: index)
    }
    

    
    
    
    func startObserving(employee e : Employee) {
        e.addObserver(self,
                      forKeyPath: "raise",
                      options: .old,
                      context: &KVOContext)
        e.addObserver(self,
                      forKeyPath: "name",
                      options: .old,
                      context: &KVOContext)
    }
    
    
    func stopObserving(employee e : Employee) {
        e.removeObserver(self, forKeyPath: "raise")
        e.removeObserver(self, forKeyPath: "name")
    }
    
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        
        NSLog("observeValue \(keyPath) of \(object)")
        if (context != &KVOContext) {
            return super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
        
        var oldValue :Any? = change?[NSKeyValueChangeKey.oldKey]
        if oldValue is NSNull {
            oldValue = nil
        }
        
        if let e = object as? Employee,
            let kp = keyPath {

            NSLog("Registering undo action with \(oldValue)")
            undoManager?.registerUndo(withTarget: e, handler:   {  (Employee) -> () in
                e.setValue(oldValue, forKeyPath: kp)
            })
        }
    }
    
    // END - called by KVO subsystem
    // ---------------------------------

    
    
    
    func windowWillClose(_ notification: Notification) {
        // remove all bindings
        NSLog("Remove all bindings.")
        self.employees = []
    }
    

    override class func autosavesInPlace() -> Bool {
        return true
    }

    override var windowNibName: String? {
        // Returns the nib file name of the document
        // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this property and override -makeWindowControllers instead.
        return "Document"
    }

    override func data(ofType typeName: String) throws -> Data {
        // Insert code here to write your document to data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning nil.
        // You can also choose to override fileWrapperOfType:error:, writeToURL:ofType:error:, or writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
        NSLog("typeName is \(typeName)")
        
        // end editing
        tableView.window?.endEditing(for: nil)
        
        return NSKeyedArchiver.archivedData(withRootObject: employees)
//        
//        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
//        
//
    }

    override func read(from data: Data, ofType typeName: String) throws {
        if let emps = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Employee] {
            employees = emps
        }
    }
    
    override func windowControllerDidLoadNib(_ windowController: NSWindowController) {
        super.windowControllerDidLoadNib(windowController)
    }


}

