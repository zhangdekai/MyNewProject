//
//  PrivacyViewController.swift
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/5.
//  Copyright © 2017年 张德凯. All rights reserved.
//

import UIKit

class PrivacyViewController: BasicViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setNavigationBarBack()
        self.setNavigationBarTitle("隐私权限")
        initilizeUI()
        
    }
    
    func initilizeUI() {
        self.view.backgroundColor = UIColor.backgroundGrayColorA()
        
        //允许非好友查看我的认证
        let backView = UIView(frame: CGRect(x: 0, y: 64 + 15, width: ScreenWidth, height: 50))
        backView.backgroundColor = UIColor.white
        self.view.addSubview(backView)
        
        let leftLabel = UILabel(frame: CGRect(x: 15, y: 15, width: 180, height: 20))
        backView.addSubview(leftLabel)
        leftLabel.textColor = UIColor.generalTitleFontBlack()
        leftLabel.font = UIFont.systemFont(ofSize: 15)
        leftLabel.text = "允许非好友查看我的认证"
        
        let selectView =  UISwitch(frame: CGRect(x: ScreenWidth - 65, y: 10, width: 60, height: 30))
        backView.addSubview(selectView)
        selectView.tag = 100
        selectView.isOn = false
        selectView.tintColor = UIColor.backgroundGrayColorA()
        selectView.onTintColor = UIColor.mainColorBlue()
        selectView.addTarget(self, action: #selector(switchDidChange(switchView:)), for: UIControlEvents.touchUpInside)
        
        
        
        //通过手机号找到我
        let backView1 = UIView(frame: CGRect(x: 0, y: 64 + 75, width: ScreenWidth, height: 50))
        backView1.backgroundColor = UIColor.white
        self.view.addSubview(backView1)
        
        let leftLabel1 = UILabel(frame: CGRect(x: 15, y: 15, width: 180, height: 20))
        backView1.addSubview(leftLabel1)
        leftLabel1.textColor = UIColor.generalTitleFontBlack()
        leftLabel1.font = UIFont.systemFont(ofSize: 15)
        leftLabel1.text = "通过手机号找到我"
        
        let selectView1 =  UISwitch(frame: CGRect(x: ScreenWidth - 65, y: 10, width: 60, height: 30))
        backView1.addSubview(selectView1)
        selectView1.tag = 101

        selectView1.isOn = true
        selectView1.tintColor = UIColor.backgroundGrayColorA()
        selectView1.onTintColor = UIColor.mainColorBlue()
        selectView1.addTarget(self, action: #selector(switchDidChange(switchView:)), for: UIControlEvents.touchUpInside)

        //通过昵称搜到我
        let backView2 = UIView(frame: CGRect(x: 0, y: 64 + 75 + 60, width: ScreenWidth, height: 50))
        backView2.backgroundColor = UIColor.white
        self.view.addSubview(backView2)
        
        let leftLabel2 = UILabel(frame: CGRect(x: 15, y: 15, width: 180, height: 20))
        backView2.addSubview(leftLabel2)
        leftLabel2.textColor = UIColor.generalTitleFontBlack()
        leftLabel2.font = UIFont.systemFont(ofSize: 15)
        leftLabel2.text = "通过昵称搜到我"
        
        let selectView2 =  UISwitch(frame: CGRect(x: ScreenWidth - 65, y: 10, width: 60, height: 30))
        backView2.addSubview(selectView2)
        selectView2.tag = 102

        selectView2.isOn = true
        selectView2.tintColor = UIColor.backgroundGrayColorA()
        selectView2.onTintColor = UIColor.mainColorBlue()
        selectView2.addTarget(self, action: #selector(switchDidChange(switchView:)), for: UIControlEvents.touchUpInside)
        
        

        
        
    }
    
    func switchDidChange(switchView:UISwitch) {
        if switchView.tag == 100 {
            
        } else if switchView.tag == 101 {
            
        } else {
            
        }
        print(switchView.isOn)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
