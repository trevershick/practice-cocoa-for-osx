//
//  NSString+Drawing.swift
//  Dice
//
//  Created by Trever Shick on 10/17/16.
//  Copyright © 2016 Trever Shick. All rights reserved.
//

import Foundation
extension NSString {
    func drawCentered(in rect:NSRect, with attributes:[String:Any]) {
        let stringSize = size(withAttributes: attributes)
        let point = NSPoint(x: rect.origin.x + (rect.width - stringSize.width)/2.0 ,
                            y: rect.origin.y + (rect.height - stringSize.height)/2.0)
        
        draw(at: point, withAttributes: attributes)
    }
}
