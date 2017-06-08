//
//  UserFeedbackCollectionViewCell.swift
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/7.
//  Copyright © 2017年 张德凯. All rights reserved.
//

import UIKit

class UserFeedbackCollectionViewCell: UICollectionViewCell {
    var selectedImageView = UIImageView()
    var deleteImageView = UIImageView()
    var deletePhotosBlock:(()-> Void)?
    var icon = UIImageView()
    var addPhotoLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.backgroundGrayColorA()
        self.addSubview(selectedImageView)
        selectedImageView.mas_makeConstraints { (make) in
            make?.left.mas_equalTo()(0)
            make?.top.mas_equalTo()(22.5)
            make?.right.mas_equalTo()(-7.5)
            make?.bottom.mas_equalTo()(0)
        }
        selectedImageView.backgroundColor = UIColor.backgroundGrayColorC()
        self.addSubview(deleteImageView)
        deleteImageView.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(15)
            make?.right.mas_equalTo()(0)
            make?.size.mas_equalTo()(CGSize(width: 15, height: 15))
        }
        deleteImageView.image = #imageLiteral(resourceName: "user_photos_delete")
        deleteImageView.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapMethod(tap:)))
        deleteImageView.addGestureRecognizer(tap)
        
        
        icon = UIImageView()
        selectedImageView.addSubview(icon)
        icon.image = #imageLiteral(resourceName: "user_feedback_addPhoto")
        icon.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(27)
            make?.centerX.equalTo()(self.selectedImageView.mas_centerX)
            make?.size.mas_equalTo()(CGSize(width: 30, height: 25))
        }
        
        addPhotoLabel = UILabel()
        selectedImageView.addSubview(addPhotoLabel)
        addPhotoLabel.mas_makeConstraints { (make) in
            make?.left.mas_equalTo()(0)
            make?.top.equalTo()(self.icon.mas_bottom)?.offset()(13)
            make?.right.mas_equalTo()(0)
        }
        addPhotoLabel.textColor = UIColor.generalSubTitleFontGray()
        addPhotoLabel.textAlignment = .center
        addPhotoLabel.font = UIFont.boldSystemFont(ofSize: 13)
        addPhotoLabel.text = "点击添加图片"
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tapMethod(tap:UITapGestureRecognizer) {
        if let block = deletePhotosBlock {
            block()
        }
    }

}
