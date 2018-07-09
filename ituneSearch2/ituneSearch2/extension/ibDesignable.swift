//
//  ibDesignable.swift
//  ituneSearch2
//
//  Created by 王安妮 on 2018/7/6.
//  Copyright © 2018年 Annie. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable

class RoundedUIImageView: UIImageView {
    @IBInspectable var round: Bool = true {
        didSet { self.setNeedsLayout() }
    }

    @IBInspectable var width: CGFloat = 0.1 {
        didSet { self.setNeedsLayout() }
    }
    
    @IBInspectable var color: CGColor = UIColor.gray.cgColor {
        didSet { self.setNeedsLayout() }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        
        if round {
            self.layer.cornerRadius = self.frame.width / 2.0
        } else {
            self.layer.cornerRadius = 0
        }
        
    }
 }
