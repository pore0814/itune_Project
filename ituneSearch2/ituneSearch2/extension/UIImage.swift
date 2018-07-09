//
//  UIImage.swift
//  ituneSearch2
//
//  Created by 王安妮 on 2018/7/6.
//  Copyright © 2018年 Annie. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2 )
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 3
        
    }
}
