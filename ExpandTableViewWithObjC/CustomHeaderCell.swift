//
//  CustomHeaderCell.swift
//  ExpandTableViewWithObjC
//
//  Created by gatesakagi on 2017/4/11.
//  Copyright © 2017年 Gates. All rights reserved.
//

import UIKit

class CustomHeaderCell: UITableViewCell {

    @IBOutlet weak var labelSectiontitle: UILabel!
    @IBOutlet weak var labelExpand: UILabel!
    @IBOutlet weak var btnSection: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
