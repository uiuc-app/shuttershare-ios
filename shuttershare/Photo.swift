//
//  Photo.swift
//  shuttershare
//
//  Created by Yosub Shin on 6/13/14.
//  Copyright (c) 2014 yosubshin. All rights reserved.
//

import UIKit

class Photo: NSObject {
    var id: Int?
    var user_id: Int?
    var create_at: Int?
    var latitude: Double?
    var longitude: Double?
    var city_id: Int?
    var group_ids: Int[] = []
    
    init(photo: NSDictionary!) {
        self.id = photo["id"] as? Int
        self.user_id = photo["user_id"] as? Int
        self.create_at = photo["create_at"] as? Int
        self.latitude = photo["latitude"] as? Double
        self.longitude = photo["longitude"] as? Double
        self.city_id = photo["city_id"] as? Int
        self.group_ids = photo["group_ids"] as Int[]
    }
}
