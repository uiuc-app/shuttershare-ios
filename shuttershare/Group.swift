//
//  Group.swift
//  shuttershare
//
//  Created by Yosub Shin on 6/13/14.
//  Copyright (c) 2014 yosubshin. All rights reserved.
//

import UIKit

class Group: NSObject {
    var id: Int?
    var name: String?
    var pass_phrase: String?
    var members: Member[] = []
    
    init(group: NSDictionary!) {
        self.id = group["id"] as? Int
        self.name = group["name"] as? String
        self.pass_phrase = group["pass_phrase"] as? String
        for member in group["members"] as NSDictionary[] {
            self.members.append(Member(member: member))
        }
    }
    
    func getMember(memberId: Int!) -> Member? {
        let members: Member[] = self.members.filter({(member: Member) -> Bool in
            return member.id == memberId})
        if members.count > 0 {
            return members[0]
        } else {
            return nil
        }
    }
}
