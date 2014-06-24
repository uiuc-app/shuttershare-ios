//
//  AuthenticatedApiController.swift
//  shuttershare
//
//  Created by Yosub Shin on 6/12/14.
//  Copyright (c) 2014 yosubshin. All rights reserved.
//

import UIKit

class AuthenticatedApiController: APIController {
    var apiKey: String
    
    override var urlString: String? {
    return rawUrl().stringByReplacingOccurrencesOfString("{{api_key}}", withString: apiKey, options: nil, range: nil)
    }
    
    func rawUrl() -> String {
        fatalError("This method should be overriden for Authenticated ApiController")
    }
    
    init(delegate: APIControllerProtocol?, withApiKey apiKey: String) {
        self.apiKey = apiKey
        super.init(delegate: delegate)
    }
}
