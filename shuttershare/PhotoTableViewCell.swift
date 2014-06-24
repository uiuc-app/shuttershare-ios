//
//  PhotoTableViewCell.swift
//  shuttershare
//
//  Created by Yosub Shin on 6/13/14.
//  Copyright (c) 2014 yosubshin. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    var photoView: UIImageView?
    var name: UILabel?
    var city: UILabel?

    init(style: UITableViewCellStyle, reuseIdentifier: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
