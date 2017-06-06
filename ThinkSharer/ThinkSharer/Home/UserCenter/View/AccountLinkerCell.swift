//
//  AccountLinkerCell.swift
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/5.
//  Copyright © 2017年 张德凯. All rights reserved.
//

import UIKit

class AccountLinkerCell: UITableViewCell {

    var linkerTextFiled = TSCustomTextFiled()
    var linkerPhoneTextFiled = TSCustomTextFiled()
    var getIdentityButton = UIButton()
    
    var confirmBlock:((_ name:String, _ phoneString:String)-> Void)?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        //应急联系人
        let phoneLabel = UILabel(frame: CGRect(x: 15, y:15, width: 120, height: 20))
        self.contentView.addSubview(phoneLabel)
        phoneLabel.textColor = UIColor.generalTitleFontBlack()
        phoneLabel.font = UIFont.systemFont(ofSize: 15)
        phoneLabel.text = "应急联系人"
        
        //确定
        let confirm =  UIButton()
        self.contentView.addSubview(confirm)
        confirm.size = CGSize(width: 60, height: 30)
        confirm.right = ScreenWidth - 15
        confirm.top = 10
        
        confirm.setTitle("确定", for: UIControlState.normal)
        confirm.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        confirm.setTitleColor(UIColor.mainColorBlue(), for: UIControlState.normal)
        
        confirm.layer.cornerRadius = 5
        confirm.layer.borderWidth = 0.5
        confirm.layer.borderColor = UIColor.mainColorBlue().cgColor
        confirm.addTarget(self, action: #selector(buttonClick), for: UIControlEvents.touchUpInside)
        
        let line = UIView(frame: CGRect(x: 0, y:49.5, width: ScreenWidth, height: 0.5))
        self.contentView.addSubview(line)
        line.backgroundColor = UIColor.seperateThinLine()
        
        //输入新密码
        linkerTextFiled.frame = CGRect(x: 15, y: line.bottom + 15, width: 200, height: 20)
        self.contentView.addSubview(linkerTextFiled)
//        linkerTextFiled.clearButtonMode = .whileEditing
        linkerTextFiled.placeholder = "姓名"
        linkerTextFiled.font = UIFont.systemFont(ofSize: 13)
        linkerTextFiled.textColor = UIColor.generalTitleFontGray()
        linkerTextFiled.maxNum = 8
        
        let line1 = UIView(frame: CGRect(x: 0, y:line.bottom + 49.5, width: ScreenWidth, height: 0.5))
        self.contentView.addSubview(line1)
        line1.backgroundColor = UIColor.seperateThinLine()
        
        linkerTextFiled.editingStatasBlcok = {(index) in
            if index == 0 {
                line1.backgroundColor = UIColor.mainColorBlue()
                
            } else {
                line1.backgroundColor = UIColor.seperateThinLine()
                
            }
            
        }
        //再次输入新密码
        linkerPhoneTextFiled.frame = CGRect(x: 15, y: line1.bottom + 15, width: 200, height: 20)
        self.addSubview(linkerPhoneTextFiled)
//        linkerPhoneTextFiled.clearButtonMode = .whileEditing
        linkerPhoneTextFiled.keyboardType = .numberPad
        linkerPhoneTextFiled.placeholder = "手机号码"
        linkerPhoneTextFiled.font = UIFont.systemFont(ofSize: 13)
        linkerPhoneTextFiled.textColor = UIColor.generalTitleFontGray()
        
        let line2 = UIView(frame: CGRect(x: 0, y:line1.bottom + 49.5, width: ScreenWidth, height: 0.5))
        self.contentView.addSubview(line2)
        line2.backgroundColor = UIColor.seperateThinLine()
        linkerPhoneTextFiled.editingStatasBlcok = {(index) in
            if index == 0 {
                line2.backgroundColor = UIColor.mainColorBlue()
                
            } else {
                line2.backgroundColor = UIColor.white
                
            }
            
        }
    }
    
    func buttonClick() {
        if let block = confirmBlock {
            block(linkerTextFiled.text ?? "youxiang", linkerPhoneTextFiled.text ?? "")
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
