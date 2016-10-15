//
//  Employee.swift
//  RaiseMan
//
//  Created by Trever Shick on 10/14/16.
//  Copyright © 2016 Trever Shick. All rights reserved.
//

import Foundation



class Employee : NSObject {
    var name: String? = "New Employee"
    var raise: Float = 0.05
    
    
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
