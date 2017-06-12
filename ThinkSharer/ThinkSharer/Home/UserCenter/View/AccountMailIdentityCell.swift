//
//  AccountMailIdentityCell.swift
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/5.
//  Copyright © 2017年 张德凯. All rights reserved.
//

import UIKit

class AccountMailIdentityCell: UITableViewCell {
    
    var mailTextFiled = TSCustomTextFiled()
    var mailLine = UIView()
    var confirmBlock:((_ mail:String)-> Void)?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        let textFont:CGFloat = 17;
        let subTextFont:CGFloat = 15;

        //验证邮箱
        let phoneLabel = UILabel(frame: CGRect(x: 15, y:15, width: 90, height: 20))
        self.addSubview(phoneLabel)
        phoneLabel.textColor = UIColor.generalTitleFontBlack()
        phoneLabel.font = UIFont.systemFont(ofSize: textFont)
        phoneLabel.text = "验证邮箱"
        
        //确定
        let confirm =  UIButton()
        self.addSubview(confirm)
        confirm.size = CGSize(width: 60, height: 30)
        confirm.right = ScreenWidth - 15
        confirm.top = 10
        
        confirm.setTitle("确定", for: UIControlState.normal)
        confirm.titleLabel?.font = UIFont.systemFont(ofSize: subTextFont)
        confirm.setTitleColor(UIColor.mainColorBlue(), for: UIControlState.normal)
        
        confirm.layer.cornerRadius = 5
        confirm.layer.borderWidth = 0.5
        confirm.layer.borderColor = UIColor.mainColorBlue().cgColor
        confirm.addTarget(self, action: #selector(buttonClick), for: UIControlEvents.touchUpInside)

        let line = UIView(frame: CGRect(x: 0, y:49.5, width: ScreenWidth, height: 0.5))
        self.addSubview(line)
        line.backgroundColor = UIColor.seperateThinLine()
        
        //请输入邮箱
        mailTextFiled.frame = CGRect(x: 15, y: line.bottom + 15, width: 200, height: 20)
        self.addSubview(mailTextFiled)
        mailTextFiled.clearButtonMode = .whileEditing
        mailTextFiled.placeholder = "请输入邮箱"
        mailTextFiled.font = UIFont.systemFont(ofSize: subTextFont)
        mailTextFiled.textColor = UIColor.generalTitleFontGray()
        
        
        mailLine.frame = CGRect(x: 0, y: line.bottom + 49.5, width: ScreenWidth, height: 0.5)
        self.addSubview(mailLine)
        mailLine.backgroundColor = UIColor.white
        
        mailTextFiled.editingStatasBlcok = {[weak self](index) in
            guard let `self` = self else {
                return
            }
            if index == 0 {
                self.mailLine.backgroundColor = UIColor.mainColorBlue()

            } else {
                self.mailLine.backgroundColor = UIColor.white

            }
            
        }

       
        
    }
    
    func buttonClick() {
        if let block = confirmBlock {
            block(mailTextFiled.text ?? "youxiang")
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
