//
//  IdentityIdentificateCell.swift
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/5.
//  Copyright © 2017年 张德凯. All rights reserved.
//

import UIKit

class IdentityIdentificateCell: UITableViewCell {

    var deletePhotoBlock:(()->Void)?
    lazy var exampleImageView: UIImageView = {
        return UIImageView()
    }()
    
    lazy var showImageView: UIImageView = {
        return UIImageView()
    }()
    lazy var deleteImageView: UIImageView = {
        return UIImageView()
    }()
    lazy var iconImageView : UIImageView = {
        return UIImageView()
    }()
    lazy var identityLabel: UILabel = {
        return UILabel()
    }()
   
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        let line = UIView()
        self.contentView.addSubview(line)
        line.backgroundColor = UIColor.backgroundGrayColorA()
        line.mas_makeConstraints { (make) in
            make?.left.mas_equalTo()(0)
            make?.top.mas_equalTo()(0)
            make?.size.mas_equalTo()(CGSize(width: ScreenWidth, height: 15))
        }
        
        
        self.contentView.addSubview(exampleImageView)
        exampleImageView.mas_makeConstraints { (make) in
            make?.left.mas_equalTo()(15)
            make?.top.equalTo()(line.mas_bottom)?.offset()(10)
            make?.size.mas_equalTo()(CGSize(width: 40, height: 30))
        }
        exampleImageView.image = UIImage(named: "login_3")
        
        let exampleLabel = UILabel()
        self.contentView.addSubview(exampleLabel)
        exampleLabel.mas_makeConstraints { (make) in
            make?.left.mas_equalTo()(15)
            make?.top.equalTo()(self.exampleImageView.mas_bottom)?.offset()(10)
            make?.size.mas_equalTo()(CGSize(width: 40, height: 20))
        }
        exampleLabel.textAlignment = .center
        exampleLabel.font = UIFont.systemFont(ofSize: 13)
        exampleLabel.textColor = UIColor.generalSubTitleFontGray()
        exampleLabel.text = "示例"
        

        self.contentView.addSubview(showImageView)
        showImageView.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.exampleImageView.mas_right)?.offset()(10)
            make?.top.equalTo()(line.mas_bottom)?.offset()(15)
            make?.size.mas_equalTo()(CGSize(width: 260, height: 195))
        }
        showImageView.image = #imageLiteral(resourceName: "testHeader")

        self.contentView.addSubview(deleteImageView)
        deleteImageView.mas_makeConstraints { (make) in
            make?.right.mas_equalTo()(-15)
            make?.top.mas_equalTo()(25)
            make?.size.mas_equalTo()(CGSize(width: 20, height: 20))
        }
        
        deleteImageView.image = #imageLiteral(resourceName: "user_photos_delete")
        deleteImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(deletePhoto))
        deleteImageView.addGestureRecognizer(tap)
        
        //身份证正面
        showImageView.addSubview(iconImageView)
        iconImageView.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(55)
            make?.centerX.equalTo()(self.showImageView.mas_centerX)
            make?.size.mas_equalTo()(CGSize(width: 105, height: 85))
        }
        iconImageView.image = #imageLiteral(resourceName: "user_feedback_addPhoto")
        
        showImageView.addSubview(identityLabel)
        identityLabel.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.iconImageView.mas_bottom)?.offset()(20)
            make?.centerX.equalTo()(self.showImageView.mas_centerX)
            make?.size.mas_equalTo()(CGSize(width: 120, height: 20))
        }
        identityLabel.textAlignment = .center
        identityLabel.font = UIFont.systemFont(ofSize: 13)
        identityLabel.textColor = UIColor.generalSubTitleFontGray()
        identityLabel.text = "身份证正面照"

        
    }
    
    func deletePhoto() {
        if let block = deletePhotoBlock {
            block()
        }
    }
    
    func hidden(hidden:Bool) {
        iconImageView.isHidden = hidden
        identityLabel.isHidden = hidden
        deleteImageView.isHidden = !hidden
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
