//
//  MainWindowController.swift
//  SpeakLinePlus
//
//  Created by Trever Shick on 10/13/16.
//  Copyright © 2016 Trever Shick. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController,
    NSWindowDelegate,
    NSSpeechSynthesizerDelegate,
    NSTableViewDelegate,
    NSTableViewDataSource,
    NSTextFieldDelegate
{
    
    @IBOutlet weak var text: NSTextField!
    @IBOutlet weak var table: NSTableView!
    @IBOutlet weak var speak: NSButton!
    @IBOutlet weak var stop: NSButton!

    let synth = NSSpeechSynthesizer()
    let voices = NSSpeechSynthesizer.availableVoices()
    let preferences = PreferenceManager()
    
    var talking : Bool = false {
        didSet {
            update()
        }
    }
    
    
    
    override var windowNibName: String? {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        synth.delegate = self
        
        talking = false

        table.delegate = self
        table.dataSource = self
        
        text.delegate = self
        
        let defaultVoice = preferences.activeVoice!
        if let defaultRow = voices.index(of: defaultVoice) {
            let indices = IndexSet(integer: defaultRow)
            table.selectRowIndexes(indices, byExtendingSelection: false)
            table.scrollRowToVisible(defaultRow)
        }
//        if let str = preferences.activeText {
//            text.stringValue = str
//        }
     }
    
    
    
    @IBAction func onSpeak(_ sender: AnyObject) {
        if (text.stringValue.isEmpty) {
            return
        }
        talking = true

        synth.startSpeaking(text.stringValue)
    }
    
    @IBAction func onStop(_ sender: AnyObject) {
        synth.stopSpeaking()
    }

    func windowShouldClose(_ sender: Any) -> Bool {
        return !talking
    }
    
    func update() {
        text.isEnabled = !talking
        speak.isEnabled = !talking
        stop.isEnabled = talking
    }
    
    func nameForVoice(voce: String!) -> String? {
        let attrs = NSSpeechSynthesizer.attributes(forVoice: voce)
        if let nm = attrs[NSVoiceName] as? String {
            return nm
        }
        else {
            return nil
        }
        
    }
    
    
    // NSSpeechSynthesizerDelegate --------------------------------
    func speechSynthesizer(_ sender: NSSpeechSynthesizer, didFinishSpeaking finishedSpeaking: Bool) {
        
        self.talking = false
        self.update()
    }
    
    
    // NSTableViewDelegate ----------------------------------
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return !talking
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        
        if let voice = table.dataSource?.tableView?(table, objectValueFor: table.tableColumns[0], row: table.selectedRow) as? String {
            NSLog("Set voice to \(voice)")
            synth.setVoice(voice)
            preferences.activeVoice = voice
        }
    }


    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        guard let voce = table.dataSource?.tableView?(table, objectValueFor: table.tableColumns[0], row: row) as? String else {
            return nil
        }

        var value : String? = "Unknown"
        
        if (tableView.tableColumns[0] == tableColumn) {
            value = nameForVoice(voce: voce)
        }
        if let cell = tableView.make(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView {
            cell.textField?.stringValue = value!
            return cell
        }
        return nil
    }
    
    // NSTextFieldDelegate ---------------------------------------------
    
    override func controlTextDidChange(_ obj: Notification) {
        
//        if let textField = obj.object as? NSTextField,
//            textField == self.text {
//            preferences.activeText = textField.stringValue
//        }
        
    }
    // end NSTextFieldDelegate -----------------------------------------
    

    // NSTableViewDataSource --------------------------------
    func numberOfRows(in tableView: NSTableView) -> Int {
        return voices.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        
        if row < 0 {
            let set = IndexSet(integer: 0)
            tableView.selectRowIndexes(set, byExtendingSelection: false)
            return nil
        }
        NSLog("Row is \(row)")
        return voices[row]
    }
}
