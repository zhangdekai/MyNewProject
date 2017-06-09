//
//  UserAbloutUsViewController.swift
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/8.
//  Copyright © 2017年 张德凯. All rights reserved.
//

import UIKit

class UserAbloutUsViewController: BasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setNavigationBarBack()
        self.setNavigationBarTitle(NSLocalizedString("About us", comment: ""))
        initilizeUI()
    }
    func initilizeUI() {
        let line = UIView(frame: CGRect(x: 0, y: 64, width: ScreenWidth, height: 15))
        self.view.addSubview(line)
        line.backgroundColor = UIColor.backgroundGrayColorA()
        
        let aboutUs = UILabel(frame: CGRect(x: 0, y:line.bottom + 25, width: ScreenWidth, height: 30))
        self.view.addSubview(aboutUs)
        aboutUs.font = UIFont.systemFont(ofSize: 20)
        aboutUs.textColor = UIColor.generalTitleFontBlack()
        aboutUs.textAlignment = .center
        aboutUs.text = "About ThinkSharer"
        
        let gap:CGFloat = 15
        let labelFont:CGFloat = 14
        
        let lawButton = UIButton(frame: CGRect(x: 15, y: aboutUs.bottom + 60, width: 120, height: 20))
        self.view.addSubview(lawButton)
        lawButton.setTitle("法律信息", for: UIControlState.normal)
        lawButton.setTitleColor(UIColor.mainColorBlue(), for: UIControlState.normal)
        lawButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        lawButton.contentHorizontalAlignment = .left
        lawButton.addTarget(self, action: #selector(buttonClick), for: UIControlEvents.touchUpInside)
    
        let reportLabel = UILabel(frame: CGRect(x: gap, y: lawButton.bottom + 20, width: ScreenWidth - 30, height: 20))
        self.view.addSubview(reportLabel)
        reportLabel.font = UIFont.systemFont(ofSize: labelFont)
        reportLabel.textColor = UIColor.generalTitleFontGray()
        reportLabel.text = "投诉举报：tscr@thinksapp.com"
        
        
        
        let marketCompany = UILabel(frame: CGRect(x: gap, y: reportLabel.bottom + 20, width: ScreenWidth - 30, height: 20))
        self.view.addSubview(marketCompany)
        marketCompany.font = UIFont.systemFont(ofSize: labelFont)
        marketCompany.textColor = UIColor.generalTitleFontGray()
        marketCompany.text = "市场合作：market@thinksapp.com"
        
        
        let mediaLabel = UILabel(frame: CGRect(x: gap, y: marketCompany.bottom + 20, width: ScreenWidth - 30, height: 20))
        self.view.addSubview(mediaLabel)
        mediaLabel.font = UIFont.systemFont(ofSize: labelFont)
        mediaLabel.textColor = UIColor.generalTitleFontGray()
        mediaLabel.text = "媒体合作：media@thinksapp.com"
        
        
        let capitalLabel = UILabel(frame: CGRect(x: gap, y: mediaLabel.bottom + 20, width: ScreenWidth - 30, height: 20))
        self.view.addSubview(capitalLabel)
        capitalLabel.font = UIFont.systemFont(ofSize: labelFont)
        capitalLabel.textColor = UIColor.generalTitleFontGray()
        capitalLabel.text = "战略合作：media@thinksapp.com"
        
        let hotLineLabel = UILabel(frame: CGRect(x: gap, y: capitalLabel.bottom + 20, width: ScreenWidth - 30, height: 20))
        self.view.addSubview(hotLineLabel)
        hotLineLabel.font = UIFont.systemFont(ofSize: labelFont)
        hotLineLabel.textColor = UIColor.generalTitleFontGray()
        hotLineLabel.text = "服务热线：4008178178"
        
        
        let serviceTimeLabel = UILabel(frame: CGRect(x: gap, y: hotLineLabel.bottom + 20, width: ScreenWidth - 30, height: 20))
        self.view.addSubview(serviceTimeLabel)
        serviceTimeLabel.font = UIFont.systemFont(ofSize: labelFont)
        serviceTimeLabel.textColor = UIColor.generalTitleFontGray()
        serviceTimeLabel.text = "服务时间：09:00——22:00"
        
        let companyLabel = UILabel(frame: CGRect(x: 0, y: ScreenHeight - 120, width: ScreenWidth, height: 20))
        self.view.addSubview(companyLabel)
        companyLabel.font = UIFont.systemFont(ofSize: 15)
        companyLabel.textColor = UIColor.generalTitleFontGray()
        companyLabel.textAlignment = .center
        companyLabel.text = "思想着文化传媒（北京）有限公司"
        
        
        let versionLabel = UILabel(frame: CGRect(x: 0, y: companyLabel.bottom + 20 , width: ScreenWidth, height: 20))
        self.view.addSubview(versionLabel)
        versionLabel.font = UIFont.systemFont(ofSize: 15)
        versionLabel.textColor = UIColor.generalTitleFontGray()
        versionLabel.textAlignment = .center
        versionLabel.text = "Version1.0"

    }
    
    func buttonClick() {
        let vc = UserLawViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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
