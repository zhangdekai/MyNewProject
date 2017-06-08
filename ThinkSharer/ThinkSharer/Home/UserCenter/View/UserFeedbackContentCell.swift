//
//  UserFeedbackContentCell.swift
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/8.
//  Copyright © 2017年 张德凯. All rights reserved.
//

import UIKit

class UserFeedbackContentCell: UICollectionViewCell {
    
    var feedbackTextView:XXTextView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        feedbackTextView = XXTextView(frame: CGRect(x: 15, y: 25, width: ScreenWidth - 30, height: 150))
        self.addSubview(feedbackTextView)
        
        feedbackTextView.backgroundColor = UIColor.white

        feedbackTextView.font = UIFont.systemFont(ofSize: 14)
        feedbackTextView.textColor = UIColor.generalTitleFontGray()
        
        feedbackTextView.layer.cornerRadius = 5
        feedbackTextView.layer.borderWidth = 0.5
        feedbackTextView.layer.borderColor = UIColor.seperateThinLine().cgColor
        
        feedbackTextView.xx_placeholder = "请简述您反馈的内容"
        feedbackTextView.xx_placeholderFont = UIFont.systemFont(ofSize: 13)
        feedbackTextView.xx_placeholderColor = UIColor.generalSubTitleFontGray()

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
