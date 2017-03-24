//
//  UIColor+Extension.swift
//  WaterFlow
//
//  Created by 管章鹏 on 17/3/24.
//  Copyright © 2017年 stw. All rights reserved.
//

import UIKit

extension UIColor{
    class func RandomColor() -> UIColor{
        return UIColor(red: CGFloat(arc4random_uniform(256))/255.0, green: CGFloat(arc4random_uniform(256))/255.0, blue: CGFloat(arc4random_uniform(256))/255.0, alpha: 1.0)
    }
}
