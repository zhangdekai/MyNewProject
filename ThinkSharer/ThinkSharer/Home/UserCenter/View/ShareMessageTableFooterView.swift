//
//  ShareMessageTableFooterView.swift
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/1.
//  Copyright © 2017年 张德凯. All rights reserved.
//

import UIKit

class ShareMessageTableFooterView: UIView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.backgroundGrayColorA()
        
        //
        let uplabel = UILabel.init(frame: CGRect(x: 15, y: 10, width: 120, height: 20))
        
        self.addSubview(uplabel)
        uplabel.font = UIFont.systemFont(ofSize: 14)
        uplabel.text = "思享者须知"
        uplabel.textAlignment = .left
        uplabel.textColor = UIColor.generalTitleFontGray()
        
        
        //
        
        
        let downLabel = UILabel.init(frame: CGRect(x: 15, y: uplabel.bottom + 10, width: ScreenWidth - 30, height: 20))
        
        self.addSubview(downLabel)
        downLabel.font = UIFont.systemFont(ofSize: 13)

        downLabel.text = "版权声明：授课者本人在产品上发表的全部原创内容（包括但不限于文字，音频，图片等）著作权均归授课者本人所有。未经授课者本人授权或许可，受众用户不得以任何载体或形式使用授课者本人的内容。"

        downLabel.textAlignment = .left
        downLabel.textColor = UIColor.generalTitleFontGray()
        downLabel.numberOfLines = 0;
        downLabel.sizeToFit()

        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
}
