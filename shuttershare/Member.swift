//
//  Member.swift
//  shuttershare
//
//  Created by Yosub Shin on 6/13/14.
//  Copyright (c) 2014 yosubshin. All rights reserved.
//

import UIKit

class Member: NSObject {
    var id: Int?
    var name: String?
    
    init(member: NSDictionary!) {
        self.id = member["id"] as? Int
        self.name = member["name"] as? String
    }
}
