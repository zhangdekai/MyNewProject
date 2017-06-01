//
//  ShareMessageFirstTableViewCell.swift
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/1.
//  Copyright © 2017年 张德凯. All rights reserved.
//

import UIKit

class ShareMessageFirstTableViewCell: UITableViewCell,UITextViewDelegate {
    
    public var textView : UITextView!
    public var numLabel:UILabel!
    public var reloadHeight:(() -> Void)?
    var number:Int!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        textView = UITextView(frame: CGRect(x: 15, y: 0, width: ScreenWidth - 30, height: 30))
        contentView.addSubview(textView)
        
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
        textView.delegate = self
        
        numLabel = UILabel(frame: CGRect(x: ScreenWidth - 40, y: 15, width: 25, height: 15))
        textView.addSubview(numLabel)
        numLabel.text = "100"
        numLabel.font = UIFont.systemFont(ofSize: 14)
        numLabel.textColor = UIColor.generalTitleFontGray()
        
        
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
    
    func textViewDidChange(_ textView: UITextView) {
        
        //获取文本中字体的size
        let size = TSPublicTool.size(with: textView.text, font: UIFont.systemFont(ofSize: 15), width:(ScreenWidth - 30))
        print("height = %f",size.height)
        //获取一行的高度
        let size1 = TSPublicTool.size(with: "我", font: UIFont.systemFont(ofSize: 15), width:(ScreenWidth - 30))

        let i:Int = Int(size.height/size1.height);
        
        if i == 1 {
            //设置全局的变量存储数字如果换行就改变这个全局变量
            number = 1
        }
        if number != i {
            number = i
            print("height = %f",number)
            textView.height = size.height
        
            if let block = reloadHeight {
                block()
            }

        }

    }

}

