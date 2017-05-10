//
//  ScheduleFetcher.swift
//  RanchForecast
//
//  Created by Trever Shick on 11/19/16.
//  Copyright © 2016 Trever Shick. All rights reserved.
//

import Cocoa

class ScheduleFetcher: NSObject {
    
    enum FetchCoursesResult {
        case Success([Course])
        case Failure(Error)
    }
    
    
    let session: URLSession
    
    override init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
        super.init()
    }
    
    func fetch(handler: @escaping (FetchCoursesResult) -> (Void)) {
        let url = "http://bookapi.bignerdranch.com/courses.json"
        
        let urlrequest = URLRequest(url: URL(string: url)!)
        let task = session.dataTask(with: urlrequest) { (data , response, error) in
            
            var result : FetchCoursesResult
            if data == nil {
                result = FetchCoursesResult.Failure(error!)
            }
            else {
                print("Received \(data!.count) bytes.")
                result = FetchCoursesResult.Success([])
            }
            
            OperationQueue.main.addOperation({ 
                handler(result)
            })
        }
        task.resume()
    }
    
}
