//
//  Employee.swift
//  RaiseMan
//
//  Created by Trever Shick on 10/14/16.
//  Copyright © 2016 Trever Shick. All rights reserved.
//

import Foundation



class Employee : NSObject, NSCoding {
    var name: String? = "New Employee"
    var raise: Float = 0.05
    
    override init() {
        super.init()
    }
    
    required init?(coder d: NSCoder) {
        if let v = d.decodeObject(forKey: "name") as? String {
            name = v
        }

        raise = d.decodeFloat(forKey: "raise")
        super.init()
    }
    
    func encode(with c: NSCoder) {
        if let v = name {
            c.encode(v, forKey: "name")
        }
        c.encode(raise, forKey: "raise")
    }
    
//    override func validateValue(_ ioValue: AutoreleasingUnsafeMutablePointer<AnyObject?>, forKey inKey: String) throws {
//        
//        if inKey == "raise" {
////            try validateRaise(value: ioValue)
//        }
//        
//    }
    
    func validateRaise(_ value: AutoreleasingUnsafeMutablePointer<NSNumber?>) throws {
        
        let raiseNumber = value.pointee// as? NSNumber
        
        if raiseNumber == nil {
            let domain = "UserInputValidationErrorDomain"
            let code = 0
            let userInfo = [NSLocalizedDescriptionKey: "An employee's raise must be a number."]
            throw NSError(domain: domain, code:code, userInfo: userInfo)
        }
    }
}
