//
//  GroupPhotosAPIController.swift
//  shuttershare
//
//  Created by Yosub Shin on 6/12/14.
//  Copyright (c) 2014 yosubshin. All rights reserved.
//

import UIKit

class GroupPhotosAPIController: AuthenticatedApiController {
    var groupId: Int?
    var after: Int?
    var limit: Int?
    
    override func rawUrl() -> String {
        var result = "https://shuttershareapp.com/shuttershare-api/groups/\(groupId!)/photos?api_key={{api_key}}"
        if after {
            result = result + "&after=\(after!)"
        }
        if limit {
            result = result + "&limit=\(limit!)"
        }
        return result
    }
}
