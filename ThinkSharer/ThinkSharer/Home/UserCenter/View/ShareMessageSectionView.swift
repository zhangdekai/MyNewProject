//
//  ShareMessageSectionView.swift
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/1.
//  Copyright © 2017年 张德凯. All rights reserved.
//

import UIKit

let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height

class ShareMessageSectionView: UIView {
    var leftLabel:UILabel!
    var rightIcon:UIImageView!
    var open:Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //
        leftLabel = UILabel.init(frame: CGRect(x: 15, y: 10, width: 120, height: 20))
        
        self.addSubview(leftLabel)
        
        leftLabel.text = "思享者简介"
        leftLabel.textAlignment = .left
        leftLabel.textColor = UIColor.generalTitleFontBlack()
        
        
        //
        
        rightIcon = UIImageView.init(frame: CGRect(x:ScreenWidth - 50, y: 10, width: 15, height: 15))
        self.addSubview(rightIcon)
        rightIcon.image = UIImage(named: "login_x")
        rightIcon.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapMethod))
        rightIcon.addGestureRecognizer(tap)
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tapMethod() {
        if !open {
            rightIcon.image = UIImage(named: "login-selected")
        } else {
            rightIcon.image = UIImage(named: "login_x")

        }
        open = !open
    }

}
