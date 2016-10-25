//
//  DieView.swift
//  Dice
//
//  Created by Trever Shick on 10/17/16.
//  Copyright © 2016 Trever Shick. All rights reserved.
//

import Cocoa


@IBDesignable
class DieView : NSView {
    
    @IBInspectable
    var cornerRadiusFactor : Float = 5.0

    @IBInspectable
    var padding : Float = 20.0
    
    dynamic var intValue : Int = 6 {
        didSet {
            needsDisplay = true
        }
    }
    dynamic var pressed = false {
        didSet {
            needsDisplay = true
        }
    }
    
    func writeToPasteboard(_ pasteboard : NSPasteboard!) {
        pasteboard.clearContents()
//        var value : NSString = "\(intValue)"
        pasteboard.writeObjects(["\(intValue)" as NSString])
    }
    
    func readFromPasteboard(pasteboard: NSPasteboard!) -> Bool {
        let objects = pasteboard.readObjects(forClasses: [NSString.self], options: [:])
        
        if let str = objects?.first as? String,
            let i = Int(str) {

            intValue = i
            return true
        }
        return false
    }
    
    @IBAction func cut(_ sender: AnyObject?) {
        copy(sender)
        intValue = 0
    }
    @IBAction func copy(_ sender: AnyObject?) {
        writeToPasteboard(NSPasteboard.general())
    }
    @IBAction func paste(_ sender: AnyObject?) {
        readFromPasteboard(pasteboard: NSPasteboard.general())
    }
    
    @IBAction func saveToPDF(sender: AnyObject!) {
        let savePanel = NSSavePanel()
        savePanel.allowedFileTypes = ["pdf"]
        
        savePanel.beginSheetModal(for: window!, completionHandler: {
            [unowned savePanel]
            (result) -> Void in
                if result == NSModalResponseOK {
                    let data = self.dataWithPDF(inside: self.bounds)
                    var error: NSError?
                    do {
                        let ok = try data.write(to: savePanel.url!, options: NSData.WritingOptions.atomic)
                    } catch let error as NSError {
                        let alert = NSAlert(error: error)
                        alert.runModal()
                    }
                    
                }
            })
    }
    
    func randomize() {
        intValue = Int(arc4random_uniform(6) + 1)
    }

    override func draw(_ dirtyRect: NSRect) {
        let bg = NSColor.lightGray
        bg.set()
        NSBezierPath.fill(dirtyRect)

        
        drawDieWith(size: bounds.size)
    }
    
    override var intrinsicContentSize: NSSize {
        return NSSize(width:100, height:100)
    }
    
    func drawDieWith(size s : NSSize) {
        let (edgeLength, f) = metricsForSize(size: s)
        let cornerRadius = edgeLength / CGFloat(cornerRadiusFactor)
        
        let dotRadius = edgeLength / 12.0
        let dotFrame = f.insetBy(dx: dotRadius * 2.5, dy: dotRadius * 2.5)
        
        NSGraphicsContext.saveGraphicsState()
        if pressed == false {
            let shadow = NSShadow()
            shadow.shadowOffset = NSSize(width:0, height:-1)
            shadow.shadowBlurRadius = edgeLength/20
            shadow.set()
        }
        
        NSColor.white.set()
        NSBezierPath(roundedRect: f, xRadius: cornerRadius, yRadius: cornerRadius).fill()
        NSGraphicsContext.restoreGraphicsState()
        
        // draw dots
        NSColor.black.set()
        func drawDot(u : CGFloat, v: CGFloat) {
            let dotOrigin = CGPoint(
                x: dotFrame.minX + dotFrame.width * u,
                y: dotFrame.minY + dotFrame.height * v)
            let dotRect = CGRect(origin: dotOrigin,size: CGSize.zero).insetBy(dx: -dotRadius, dy: -dotRadius)
            
            NSBezierPath(ovalIn: dotRect).fill()
        }
        if (1..<7).contains(intValue) {
            
            if [1,3,5].contains(intValue) {
                drawDot(u: 0.5,v: 0.5)
            }
            if (2..<7).contains(intValue) {
                drawDot(u: 0, v: 1)
                drawDot(u: 1, v: 0)
                
            }
            if (4..<7).contains(intValue) {
                drawDot(u: 1, v: 1)
                drawDot(u: 0, v: 0)
            }
            if 6 == intValue {
                drawDot(u: 0, v: 0.5)
                drawDot(u: 1, v: 0.5)
            }
        } else {
            let paraStyle = NSParagraphStyle.default().mutableCopy() as! NSMutableParagraphStyle

            paraStyle.alignment = .center
            
            let font = NSFont.systemFont(ofSize: edgeLength * 0.5)
            let attrs : [String:Any] = [
                NSForegroundColorAttributeName : NSColor.black,
                NSFontAttributeName : font,
                NSParagraphStyleAttributeName : paraStyle
            ] as [String : Any]
            let string : NSString = "\(intValue)" as NSString

            string.drawCentered(in: f, with: attrs)
        }

        
        
    }
    
    func metricsForSize(size : NSSize) ->
        (edgeLenth: CGFloat, dieFrame : NSRect) {
            let edgeLength = min(size.width, size.height)
            let padding = CGFloat(self.padding)
            let drawingBounds = NSRect(x: 0, y: 0, width: edgeLength, height : edgeLength)
            var dieFrame = drawingBounds.insetBy(dx: padding, dy: padding)
            
            if pressed {
                dieFrame = dieFrame.offsetBy(dx: padding/4, dy: -padding/4)
            }
            return (edgeLength, dieFrame)
    }
    
    func isInDieFrame(_ p : NSPoint) -> Bool {
        let converted = convert(p, from: nil)
        let (edgeLength, dieFrame) = metricsForSize(size: bounds.size)
        
        let cornerRadius = edgeLength / CGFloat(cornerRadiusFactor)
        
        return NSBezierPath(roundedRect: dieFrame, xRadius: cornerRadius, yRadius: cornerRadius).contains(converted)
    }
    
    override func mouseUp(with event: NSEvent) {
        NSLog("mouseUp \(event)")
        pressed = false
        if isInDieFrame(event.locationInWindow) && event.clickCount > 1 {
            randomize()
        }
    }
    
    override func mouseDown(with event: NSEvent) {
        if isInDieFrame(event.locationInWindow) {
            pressed = true
        }
    }
    override func mouseDragged(with event: NSEvent) {
        NSLog("mouseDragged \(event)")
    }
    
    override var acceptsFirstResponder: Bool {
        return true
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    override func resignFirstResponder() -> Bool {
        return true
    }
    
    // call interpret key events for default behavior
    override func keyDown(with event: NSEvent) {
        interpretKeyEvents([event])
    }

    override func drawFocusRingMask() {
        NSBezierPath.fill(bounds)
    }
    // called when someone hits 'tab'
    override func insertTab(_ sender: Any?) {
        window?.selectNextKeyView(sender)
    }
    
    // ... shift tab
    override func insertBacktab(_ sender: Any?) {
        window?.selectPreviousKeyView(sender)
    }
    
    override var focusRingMaskBounds: NSRect {
        return bounds
    }
    
    // called when added to window hierarchy
    override func viewDidMoveToWindow() {
        window?.acceptsMouseMovedEvents = true
        
        let options = NSTrackingAreaOptions.mouseEnteredAndExited.union(NSTrackingAreaOptions.activeAlways).union(NSTrackingAreaOptions.inVisibleRect)
        let trackingArea = NSTrackingArea(rect: NSRect(),
                                          options: options,
                                          owner: self,
                                          userInfo: [:])
        addTrackingArea(trackingArea)
    }
    
    // request focus when the mouse rolls over.
    override func mouseEntered(with event: NSEvent) {
        window?.makeFirstResponder(self)
    }
    
    // this is called by NSControler after interpreting key events
    override func insertText(_ insertString: Any) {
        if let num : Int = Int(insertString as! String) {
            intValue = num
        }
    }
}
