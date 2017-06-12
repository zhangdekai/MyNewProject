//
//  AccountTableFooterView.swift
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/5.
//  Copyright © 2017年 张德凯. All rights reserved.
//

import UIKit

class AccountTableFooterView: UIView {

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 100))
        self.backgroundColor = UIColor.backgroundGrayColorA()
        //积极联系人规则
        let phoneLabel = UILabel(frame: CGRect(x: 15, y: 25, width: ScreenWidth - 30, height: 20))
        self.addSubview(phoneLabel)
        phoneLabel.textColor = UIColor.generalSubTitleFontGray()
        phoneLabel.font = UIFont.systemFont(ofSize: 15)
        phoneLabel.text = "当你把这个人设为联系人时，我们将以短信通知TA，并在紧急时刻可能联系TA。"
        phoneLabel.numberOfLines = 0
        phoneLabel.sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
  
