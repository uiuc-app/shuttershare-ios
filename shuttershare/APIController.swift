//
//  APIController.swift
//  swift-checklist
//
//  Created by Yosub Shin on 6/8/14.
//  Copyright (c) 2014 yosubshin. All rights reserved.
//

import UIKit

protocol APIControllerProtocol {
    func didReceiveAPIResults(results: NSDictionary)
}

class APIController {
    
    var delegate: APIControllerProtocol?
    var urlString: String? {
        return nil
    }
    
    init(delegate: APIControllerProtocol?) {
        self.delegate = delegate
    }
    
    func executeRequest() {
        var url: NSURL = NSURL(string: urlString)
        var request: NSURLRequest = NSURLRequest(URL: url)
        NSLog("Making a HTTP request with request:\(request)")
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if error? {
                NSLog("Error: \(error.localizedDescription)", error)
            } else {
                var error: NSError?
                let jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
                if error? {
                    NSLog("HTTP Error \(error?.localizedDescription)", error!)
                } else {
                    NSLog("Results received")
                    self.delegate?.didReceiveAPIResults(jsonResult)
                }
            }
            })
    }
}
