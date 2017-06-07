//
//  SwiftConstraint.swift
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/5.
//  Copyright © 2017年 张德凯. All rights reserved.
//

import UIKit
import Foundation


public extension CGFloat {
    /// 返回根据屏幕缩放后的尺寸
    public var scalValue: CGFloat {
        let scal = UIScreen.main.bounds.size.width / 375.0
        return scal * CGFloat(native)

    }
}
