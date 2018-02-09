//
//  CoursesTableViewCell.swift
//  AppCode
//
//  Created by Leon T Long on 2/8/18.
//  Copyright © 2018 leontaolong. All rights reserved.
//

import UIKit

class CoursesTableViewCell: UITableViewCell {

    @IBOutlet weak var CourseDisplayName: UILabel!
    @IBOutlet weak var cellBGImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
