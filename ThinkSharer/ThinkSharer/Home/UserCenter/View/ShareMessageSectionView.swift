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
    var grayLine :UIView!
    var openOrCloseBlock:((_ open:Bool) -> Void)?
    var addAddressBlock:(() -> Void)?

    private var open:Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let selfW = frame.size.width
        let selfH = frame.size.height
        //
        leftLabel = UILabel.init(frame: CGRect(x: 15, y: 15, width: 120, height: 20))
        
        self.addSubview(leftLabel)
        
        leftLabel.text = "思享者简介"
        leftLabel.textAlignment = .left
        leftLabel.textColor = UIColor.generalTitleFontBlack()
        
        
        //
        
        rightIcon = UIImageView.init(frame: CGRect(x:ScreenWidth - 35, y: 20, width: 20, height: 10))
        self.addSubview(rightIcon)
        rightIcon.image = UIImage(named: "userMessage_ArrowsDown")
        rightIcon.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapMethod))
        rightIcon.addGestureRecognizer(tap)
        
        
        grayLine = UIView(frame: CGRect(x: 0, y: selfH - 0.5, width: selfW, height: 0.5))
        self.addSubview(grayLine)
        grayLine.backgroundColor = UIColor.seperateThinLine()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setRightImage(open:Bool) {
        if open {
            rightIcon.image = UIImage(named: "userMessage_ArrowsUp")
            grayLine.backgroundColor = UIColor.seperateThinLine()
        } else {
            rightIcon.image = UIImage(named: "userMessage_ArrowsDown")
            grayLine.backgroundColor = UIColor.white

            
        }
        self.open = open
    }
    func tapMethod() {
        if leftLabel.text == "地址信息" {
            if let block = addAddressBlock {
                block()
            }
            
        } else {
            if let block = openOrCloseBlock {
                block(open)
            }
            open = !open
        }
        
    }

}
