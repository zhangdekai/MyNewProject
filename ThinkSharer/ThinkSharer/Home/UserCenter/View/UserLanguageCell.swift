//
//  UserLanguageCell.swift
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/6.
//  Copyright © 2017年 张德凯. All rights reserved.
//

import UIKit

class UserLanguageCell: UITableViewCell {
    
    var languageLabel : UILabel!
    var confirm:UIButton!
    var languageSelectedIndex:Int = 0
    var selectStatsIndex:((_ index:Int)-> Void)?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        //简体中文
        languageLabel = UILabel(frame: CGRect(x: 15, y:15, width: 200, height: 20))
        self.addSubview(languageLabel)
        languageLabel.textColor = UIColor.generalTitleFontBlack()
        languageLabel.font = UIFont.systemFont(ofSize: 15)
        languageLabel.text = "简体中文"
        
        //iocn
        confirm =  UIButton()
        self.addSubview(confirm)
        confirm.size = CGSize(width: 18, height: 18)
        confirm.right = ScreenWidth - 15
        confirm.top = 15
        
        confirm.setImage(UIImage.init(named: "user_language_normal"), for: UIControlState.normal)

        confirm.addTarget(self, action: #selector(buttonClick(button:)), for: UIControlEvents.touchUpInside)
        
        let line = UIView(frame: CGRect(x: 0, y:49.5, width: ScreenWidth, height: 0.5))
        self.addSubview(line)
        line.backgroundColor = UIColor.seperateThinLine()

    }
    
    func setButtonImage(style:Int) {
        if style == 0 {
            confirm.setImage(UIImage.init(named: "user_language_normal"), for: UIControlState.normal)
        } else {
            confirm.setImage(UIImage.init(named: "user_language_selected"), for: UIControlState.normal)
        }
        languageSelectedIndex = style
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buttonClick(button:UIButton) {
        if languageSelectedIndex == 0 {
            button.setImage(UIImage.init(named: "user_language_selected"), for: UIControlState.normal)
        } else {
            button.setImage(UIImage.init(named: "user_language_normal"), for: UIControlState.normal)

        }
       
        languageSelectedIndex = languageSelectedIndex == 0 ? 0:1
        if let block = selectStatsIndex {
            block(languageSelectedIndex)
        }
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
