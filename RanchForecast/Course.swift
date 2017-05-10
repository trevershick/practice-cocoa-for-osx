//
//  Course.swift
//  RanchForecast
//
//  Created by Trever Shick on 11/19/16.
//  Copyright © 2016 Trever Shick. All rights reserved.
//

import Cocoa

class Course: NSObject {
    let title: String
    let url: NSURL
    let nextStartDate : NSDate
    
    init(title: String, url: NSURL, nextStartDate: NSDate) {
        self.title = title
        self.url = url
        self.nextStartDate = nextStartDate
        super.init()
    }
    
}
