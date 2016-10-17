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
    

    override func draw(_ dirtyRect: NSRect) {
        let bg = NSColor.lightGray
        bg.set()
        NSBezierPath.fill(dirtyRect)

        
        drawDieWith(size: bounds.size)
    }
    
    override var intrinsicContentSize: NSSize {
        return NSSize(width:50, height:50)
    }
    
    func drawDieWith(size s : NSSize) {
        let (edgeLength, frame) = metricsForSize(size: s)
        let cornerRadius = edgeLength / CGFloat(cornerRadiusFactor)
        
        let dotRadius = edgeLength / 12.0
        let dotFrame = frame.insetBy(dx: dotRadius * 2.5, dy: dotRadius * 2.5)
        
        NSGraphicsContext.saveGraphicsState()
        let shadow = NSShadow()
        shadow.shadowOffset = NSSize(width:0, height:-1)
        shadow.shadowBlurRadius = edgeLength/20
        shadow.set()
        
        
        NSColor.white.set()
        NSBezierPath(roundedRect: frame, xRadius: cornerRadius, yRadius: cornerRadius).fill()
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
        
        if (1..<7).index(of: intValue) != nil {
            if [1,3,5].index(of: intValue) != nil {
                drawDot(u: 0.5,v: 0.5)
            }
            if (2..<7).index(of:intValue) != nil {
                drawDot(u: 0, v: 1)
                drawDot(u: 1, v: 0)
                
            }
            if (4..<7).index(of:intValue) != nil {
                drawDot(u: 1, v: 1)
                drawDot(u: 0, v: 0)
            }
            if 6 == intValue {
                drawDot(u: 0, v: 0.5)
                drawDot(u: 1, v: 0.5)
            }
        }
        
    }
    
    func metricsForSize(size : NSSize) ->
        (edgeLenth: CGFloat, dieFrame : NSRect) {
            let edgeLength = min(size.width, size.height)
            let padding = CGFloat(self.padding)
            let drawingBounds = NSRect(x: 0, y: 0, width: edgeLength, height : edgeLength)
            let dieFrame = drawingBounds.insetBy(dx: padding, dy: padding)
            return (edgeLength, dieFrame)
    }
}
