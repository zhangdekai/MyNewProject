//
//  UserHelpFeedbackCell.swift
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/7.
//  Copyright © 2017年 张德凯. All rights reserved.
//

import UIKit

class UserHelpFeedbackCell: UITableViewCell {

    var helpLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        //简体中文
        helpLabel = UILabel(frame: CGRect(x: 15, y:15, width: ScreenWidth, height: 20))
        self.contentView.addSubview(helpLabel)
        helpLabel.textColor = UIColor.generalTitleFontBlack()
        helpLabel.font = UIFont.systemFont(ofSize: 15)

        
        
        let line = UIView(frame: CGRect(x: 0, y:49.5, width: ScreenWidth, height: 0.5))
        self.contentView.addSubview(line)
        line.backgroundColor = UIColor.seperateThinLine()
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
