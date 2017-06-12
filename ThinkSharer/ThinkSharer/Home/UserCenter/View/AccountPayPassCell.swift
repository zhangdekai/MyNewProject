//
//  AccountPayPassCell.swift
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/5.
//  Copyright © 2017年 张德凯. All rights reserved.
//

import UIKit

class AccountPayPassCell: UITableViewCell {

    var passWordTextFiled = TSCustomTextFiled()
    var passWordAgainTextFiled = TSCustomTextFiled()
    var identityTextFiled = TSCustomTextFiled()
    var getIdentityButton = UIButton()
    
    var getIdentityBlock:((_ button:UIButton)-> Void)?
    var confirmBlock:((_ payPassWord:String, _ idnetity:String)-> Void)?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        let textFont:CGFloat = 17;
        let subTextFont:CGFloat = 15;

        //支付密码设置
        let phoneLabel = UILabel(frame: CGRect(x: 15, y:15, width: 120, height: 20))
        self.contentView.addSubview(phoneLabel)
        phoneLabel.textColor = UIColor.generalTitleFontBlack()
        phoneLabel.font = UIFont.systemFont(ofSize: textFont)
        phoneLabel.text = "支付密码设置"
        
        //确定
        let confirm =  UIButton()
        self.contentView.addSubview(confirm)
        confirm.size = CGSize(width: 60, height: 30)
        confirm.right = ScreenWidth - 15
        confirm.top = 10
        
        confirm.setTitle("确定", for: UIControlState.normal)
        confirm.titleLabel?.font = UIFont.systemFont(ofSize: subTextFont)
        confirm.setTitleColor(UIColor.mainColorBlue(), for: UIControlState.normal)
        
        confirm.layer.cornerRadius = 5
        confirm.layer.borderWidth = 0.5
        confirm.layer.borderColor = UIColor.mainColorBlue().cgColor
        confirm.addTarget(self, action: #selector(buttonClick(button:)), for: UIControlEvents.touchUpInside)
        
        let line = UIView(frame: CGRect(x: 0, y:49.5, width: ScreenWidth, height: 0.5))
        self.contentView.addSubview(line)
        line.backgroundColor = UIColor.seperateThinLine()
        
        //输入新密码
        passWordTextFiled.frame = CGRect(x: 15, y: line.bottom + 15, width: 200, height: 20)
        self.contentView.addSubview(passWordTextFiled)
//        passWordTextFiled.clearButtonMode = .whileEditing
        passWordTextFiled.keyboardType = .numberPad
        passWordTextFiled.placeholder = "输入新密码"
        passWordTextFiled.font = UIFont.systemFont(ofSize: subTextFont)
        passWordTextFiled.textColor = UIColor.generalTitleFontGray()
        passWordTextFiled.maxNum = 6
        
        let line1 = UIView(frame: CGRect(x: 0, y:line.bottom + 49.5, width: ScreenWidth, height: 0.5))
        self.contentView.addSubview(line1)
        line1.backgroundColor = UIColor.seperateThinLine()
        
        passWordTextFiled.editingStatasBlcok = {(index) in
            if index == 0 {
                line1.backgroundColor = UIColor.mainColorBlue()
                
            } else {
                line1.backgroundColor = UIColor.seperateThinLine()
                
            }
            
        }
        
        //再次输入新密码
        passWordAgainTextFiled.frame = CGRect(x: 15, y: line1.bottom + 15, width: 200, height: 20)
        self.addSubview(passWordAgainTextFiled)
//        passWordAgainTextFiled.clearButtonMode = .whileEditing
        passWordAgainTextFiled.keyboardType = .numberPad

        passWordAgainTextFiled.placeholder = "再次输入新密码"
        passWordAgainTextFiled.font = UIFont.systemFont(ofSize: subTextFont)
        passWordAgainTextFiled.textColor = UIColor.generalTitleFontGray()
        passWordAgainTextFiled.maxNum = 6
        
        let line2 = UIView(frame: CGRect(x: 0, y:line1.bottom + 49.5, width: ScreenWidth, height: 0.5))
        self.contentView.addSubview(line2)
        line2.backgroundColor = UIColor.seperateThinLine()
        
        passWordAgainTextFiled.editingStatasBlcok = {(index) in
            if index == 0 {
                line2.backgroundColor = UIColor.mainColorBlue()
                
            } else {
                line2.backgroundColor = UIColor.seperateThinLine()
                
            }
            
        }
        //输入验证码
        identityTextFiled.frame = CGRect(x: 15, y: line2.bottom + 15, width: 200, height: 20)
        self.contentView.addSubview(identityTextFiled)
//        identityTextFiled.clearButtonMode = .whileEditing
        identityTextFiled.keyboardType = .numberPad
        identityTextFiled.placeholder = "输入验证码"
        identityTextFiled.font = UIFont.systemFont(ofSize: subTextFont)
        identityTextFiled.textColor = UIColor.generalTitleFontGray()
        identityTextFiled.maxNum = 6
        
        //确定
        self.addSubview(getIdentityButton)
        getIdentityButton.size = CGSize(width: 100, height: 30)
        getIdentityButton.right = ScreenWidth - 15
        getIdentityButton.top = line2.bottom + 10
        
        getIdentityButton.setTitle("获取验证码", for: UIControlState.normal)
        getIdentityButton.titleLabel?.font = UIFont.systemFont(ofSize: subTextFont)
        getIdentityButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        getIdentityButton.backgroundColor = UIColor.backgroundGrayColorC()
        getIdentityButton.layer.cornerRadius = 5
        getIdentityButton.addTarget(self, action: #selector(buttonClick(button:)), for: UIControlEvents.touchUpInside)
        
        confirm.addTarget(self, action: #selector(buttonClick1(button:)), for:
            UIControlEvents.touchUpInside)
        
        
        let line3 = UIView(frame: CGRect(x: 0, y:line2.bottom + 49.5, width:
            ScreenWidth, height: 0.5))
        self.contentView.addSubview(line3)
        line3.backgroundColor = UIColor.white

        identityTextFiled.editingStatasBlcok = {(index) in
            if index == 0 {
                line3.backgroundColor = UIColor.mainColorBlue()
                
            } else {
                line3.backgroundColor = UIColor.white
                
            }
        }
        
    }
    
    func buttonClick(button:UIButton) {
        
        if let block = confirmBlock {
            block(passWordAgainTextFiled.text ?? "", identityTextFiled.text ?? "")
        }
    }
    
    func buttonClick1(button:UIButton) {
        
        if let block = getIdentityBlock {
            block(button)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
