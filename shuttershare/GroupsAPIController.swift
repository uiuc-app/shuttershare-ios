//
//  GroupsAPIController.swift
//  shuttershare
//
//  Created by Yosub Shin on 6/12/14.
//  Copyright (c) 2014 yosubshin. All rights reserved.
//

import UIKit

class GroupsAPIController: AuthenticatedApiController {
    let rawUrlTemplate = "https://shuttershareapp.com/shuttershare-api/groups?api_key={{api_key}}"
    
    override func rawUrl() -> String {
        return self.rawUrlTemplate
    }
}
