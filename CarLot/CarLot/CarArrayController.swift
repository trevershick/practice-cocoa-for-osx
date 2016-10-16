//
//  CarArrayController.swift
//  CarLot
//
//  Created by Trever Shick on 10/15/16.
//  Copyright © 2016 Trever Shick. All rights reserved.
//

import Cocoa

class CarArrayController: NSArrayController {

    override func newObject() -> Any {
        let newObject = super.newObject() as! NSObject
        
        newObject.setValue(NSDate(), forKey: "datePurchased")
        
        return newObject
    }
}
