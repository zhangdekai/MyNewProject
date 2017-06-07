//
//  UserHelpAndFeedbackTableHeaderView.swift
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/7.
//  Copyright © 2017年 张德凯. All rights reserved.
//

import UIKit

class UserHelpAndFeedbackTableHeaderView: UIView {
    
    var headerImageView = UIImageView()
    var headerBlock:((_ index:Int)-> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //headerImage
        self.addSubview(headerImageView)
        let headerHeight = TSPublicTool.getRealPX(230)
        headerImageView.mas_makeConstraints { (make) in
            make?.left.mas_equalTo()(0)
            make?.top.mas_equalTo()(0)
            make?.size.mas_equalTo()(CGSize(width: ScreenWidth, height: headerHeight))
        }
        headerImageView.image = UIImage(named: "testHeader")
        let imageWidth = TSPublicTool.getRealPX(65)
        let imageHeight = TSPublicTool.getRealPX(78)
        let imageName = [#imageLiteral(resourceName: "user_customer_service"),#imageLiteral(resourceName: "user_teacher_service"),#imageLiteral(resourceName: "user_feedback")]
        let labelName = ["客服咨询","导师服务","信息反馈"]
        let gap = (ScreenWidth - 3 * imageWidth) / 4
        
        for i in 0..<3 {
            let backView = UIView(frame: CGRect(x: gap + CGFloat(i) * (imageWidth + gap), y: headerHeight, width:
                imageWidth, height: imageHeight))
            self.addSubview(backView)
            
            backView.isUserInteractionEnabled = true
            backView.tag = 100 + i
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapMethod(tap:)))
            backView.addGestureRecognizer(tap)
            
            let icon = UIImageView()
            backView.addSubview(icon)
            icon.mas_makeConstraints({ (make) in
                make?.top.mas_equalTo()(15)
                make?.centerX.equalTo()(backView.mas_centerX)
                make?.size.mas_equalTo()(CGSize(width: 25, height: 25))
            })
            icon.image = imageName[i]
            
            
            let label = UILabel()
            backView.addSubview(label)
            label.mas_makeConstraints({ (make) in
                make?.top.equalTo()(icon.mas_bottom)?.offset()(10)
                make?.left.equalTo()(backView.mas_left)
                make?.right.equalTo()(backView.mas_right)
                make?.height.mas_equalTo()(20)
            })
            
            label.textAlignment = .center
            label.textColor = UIColor.generalSubTitleFontGray()
            label.font = UIFont.systemFont(ofSize: 13)
            label.text = labelName[i]
        }
        
        //新手服务
        
        let backView = UIView(frame: CGRect(x: 0, y: headerHeight + imageHeight, width:
            ScreenWidth, height: 50))
        self.addSubview(backView)
        backView.backgroundColor = UIColor.backgroundGrayColorA()
        backView.isUserInteractionEnabled = true
        backView.tag = 103
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapMethod(tap:)))
        backView.addGestureRecognizer(tap)
        let label = UILabel()
        backView.addSubview(label)
        label.mas_makeConstraints({ (make) in
            make?.top.mas_equalTo()(15)
            make?.left.mas_equalTo()(15)
            make?.size.mas_equalTo()(CGSize(width: 100, height: 20))
        })
        
        label.textColor = UIColor.generalSubTitleFontGray()
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = NSLocalizedString("新手帮助", comment: "新手帮助")
        
        self.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: backView.frame.maxY)
    }
    
    func tapMethod(tap:UITapGestureRecognizer) {
        if let block = headerBlock {
            if tap.view?.tag == 100 {
                block(0)
                
            } else if tap.view?.tag == 101{
                block(1)
                
            }else if tap.view?.tag == 102{
                block(2)
                
            }else if tap.view?.tag == 103{
                block(3)
                
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
