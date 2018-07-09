//
//  ituneTableViewCell.swift
//  ituneSearch2
//
//  Created by 王安妮 on 2018/7/5.
//  Copyright © 2018年 Annie. All rights reserved.
//

import UIKit

class ituneTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var songimageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        songimageView.setRounded()
    }

   
    
}
