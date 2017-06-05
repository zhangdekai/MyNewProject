//
//  AccountSecurePhoneIdentityView.swift
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/5.
//  Copyright © 2017年 张德凯. All rights reserved.
//

import UIKit

class AccountSecurePhoneIdentityView: UIView {

    var phoneTextFiled = UITextField()
    
    var changePhoneTextFiled = UITextField()
    
    var identityTextfiled = UITextField()
    var getIdentityButton = UIButton()
    
    var confirmBlock:((_ phone:String, _ identity:String)-> Void)?
    var getIdentityBlock:((_ phone:String, _ button:UIButton)-> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 165))
        
        
        let grayLine = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 15))
        self.addSubview(grayLine)
        grayLine.backgroundColor = UIColor.backgroundGrayColorA()

        
        //手机号
        let phoneLabel = UILabel(frame: CGRect(x: 15, y: grayLine.bottom + 15, width: 60, height: 20))
        self.addSubview(phoneLabel)
        phoneLabel.textColor = UIColor.generalTitleFontBlack()
        phoneLabel.font = UIFont.systemFont(ofSize: 15)
        phoneLabel.text = "手机号"
        
        //
        self.addSubview(phoneTextFiled)
        phoneTextFiled.frame = CGRect(x: phoneLabel.right + 10, y: phoneLabel.top, width: 150, height: 20)
        phoneTextFiled.keyboardType = .numberPad
        phoneTextFiled.font = UIFont.systemFont(ofSize: 15)
        phoneTextFiled.textColor = UIColor.generalTitleFontBlack()
        phoneTextFiled.text = "+86 15612345678"
        
        
        //确定
        let confirm =  UIButton()
        self.addSubview(confirm)
        confirm.size = CGSize(width: 60, height: 30)
        confirm.right = ScreenWidth - 15
        confirm.top = grayLine.bottom + 10
        
        confirm.setTitle("确定", for: UIControlState.normal)
        confirm.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        confirm.setTitleColor(UIColor.mainColorBlue(), for: UIControlState.normal)
        
        confirm.layer.cornerRadius = 5
        confirm.layer.borderWidth = 0.5
        confirm.layer.borderColor = UIColor.mainColorBlue().cgColor
        
        
        let line = UIView(frame: CGRect(x: 0, y: 15 + 49.5, width: ScreenWidth, height: 0.5))
        self.addSubview(line)
        line.backgroundColor = UIColor.seperateThinLine()
        
        changePhoneTextFiled.frame = CGRect(x: 15, y: line.bottom + 15, width: 200, height: 20)
        self.addSubview(changePhoneTextFiled)
        changePhoneTextFiled.placeholder = "更换手机号"
        changePhoneTextFiled.keyboardType = .numberPad

        changePhoneTextFiled.font = UIFont.systemFont(ofSize: 13)
        changePhoneTextFiled.textColor = UIColor.generalTitleFontGray()

        
        let line1 = UIView(frame: CGRect(x: 0, y: line.bottom + 49.5, width: ScreenWidth, height: 0.5))
        self.addSubview(line1)
        line1.backgroundColor = UIColor.seperateThinLine()

        
        identityTextfiled.frame = CGRect(x: 15, y: line1.bottom + 15, width: 200, height: 20)
        self.addSubview(identityTextfiled)
        identityTextfiled.placeholder = "输入验证码"
        identityTextfiled.font = UIFont.systemFont(ofSize: 13)
        identityTextfiled.textColor = UIColor.generalTitleFontGray()
        identityTextfiled.keyboardType = .numberPad

        
        //确定
        self.addSubview(getIdentityButton)
        getIdentityButton.size = CGSize(width: 100, height: 30)
        getIdentityButton.right = ScreenWidth - 15
        getIdentityButton.top = line1.bottom + 10
        
        getIdentityButton.setTitle("获取验证码", for: UIControlState.normal)
        getIdentityButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        getIdentityButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        getIdentityButton.backgroundColor = UIColor.backgroundGrayColorC()
        getIdentityButton.layer.cornerRadius = 5
        getIdentityButton.addTarget(self, action: #selector(buttonClick(button:)), for: UIControlEvents.touchUpInside)
    
        confirm.addTarget(self, action: #selector(buttonClick1(button:)), for: UIControlEvents.touchUpInside)

    }
    
    func buttonClick(button:UIButton) {
        
        if let block = getIdentityBlock {
            block(changePhoneTextFiled.text ?? "", button)
        }
    }
    
    func buttonClick1(button:UIButton) {
        
        if let block = confirmBlock {
            block(changePhoneTextFiled.text ?? "", identityTextfiled.text ?? "")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
