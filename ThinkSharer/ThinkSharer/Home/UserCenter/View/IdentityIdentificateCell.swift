//
//  IdentityIdentificateCell.swift
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/5.
//  Copyright © 2017年 张德凯. All rights reserved.
//

import UIKit

class IdentityIdentificateCell: UITableViewCell {

    lazy var exampleImageView: UIImageView = {
        return UIImageView()
    }()
    
    lazy var showImageView: UIImageView = {
        return UIImageView()
    }()
    lazy var deleteImageView: UIImageView = {
        return UIImageView()
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.addSubview(exampleImageView)
        exampleImageView.mas_makeConstraints { (make) in
            make?.left.mas_equalTo()(15)
            make?.top.mas_equalTo()(10)
            make?.size.mas_equalTo()(CGSize(width: 40, height: 30))
        }
        exampleImageView.image = UIImage(named: "login_3")

        self.contentView.addSubview(showImageView)
        showImageView.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.exampleImageView.mas_right)?.offset()(10)
            make?.top.mas_equalTo()(10)
            make?.size.mas_equalTo()(CGSize(width: 260, height: 195))
        }
        showImageView.image = UIImage(named: "testHeader")

        self.contentView.addSubview(deleteImageView)
        deleteImageView.mas_makeConstraints { (make) in
            make?.right.mas_equalTo()(-15)
            make?.top.mas_equalTo()(10)
            make?.size.mas_equalTo()(CGSize(width: 30, height: 30))
        }
        
        deleteImageView.image = UIImage(named: "login_3")
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
