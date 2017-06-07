//
//  UserLangageViewController.swift
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/6.
//  Copyright © 2017年 张德凯. All rights reserved.
//

import UIKit

/*
 当前语言
 
 "en-US",
 "zh-Hans-US",
  en
 
 
 */

class UserLangageViewController: BasicViewController {
    
    var tableView:UITableView!
    var languageArray:[String]!
    var standerLanguageArray:[String]!

    var languageSelectArray = [Int]()
    var languages:NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setNavigationBarBack()
        self.setNavigationBarTitle(NSLocalizedString("Language Settings", comment: ""))

        initilizeUI()
    }
    
    func initilizeUI() {
        tableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), style: UITableViewStyle.plain)
        self.view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserLanguageCell.self, forCellReuseIdentifier: "UserLanguageCell")
        

        
        // 切换语言前
        
        let lanStr = UserDefaults.standard.object(forKey: "Think_Sharer_APP_Language")as?String
        print("语言",lanStr ?? "")
        
        
//       languages = NSDictionary(dictionary: ["简体中文":"zh-Hans","English":"en"])//"English(US)":"en-US",
        
        languageArray = ["简体中文","English"]
        standerLanguageArray = ["zh-Hans","en"]
        if let lan = lanStr {
            for i in 0..<languageArray.count {
                if standerLanguageArray[i] == lan {
                    languageSelectArray.append(1)
                } else {
                    languageSelectArray.append(0)
                }
            }
        } else {
            for i in 0..<languageArray.count {
                if i == 0 {
                    languageSelectArray.append(1)
                } else {
                    languageSelectArray.append(0)

                }
            }
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension UserLangageViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageSelectArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserLanguageCell")as!UserLanguageCell
        cell.setButtonImage(style: languageSelectArray[indexPath.row])
       
        cell.languageLabel.text = languageArray[indexPath.row]

        return cell
       
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 15))
        
        view.backgroundColor = UIColor.backgroundGrayColorA()
        
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0..<self.languageSelectArray.count {
            if indexPath.row == i {
                self.languageSelectArray[indexPath.row] = 1
            } else {
                self.languageSelectArray[i] = 0
            }
        }
        
        let language = standerLanguageArray[indexPath.row]
        
        // 设置语言
        
        Bundle.setLanguage(language)
        
//        self.showHud(withTextAndAutoHidden: NSLocalizedString("setting language", comment: "正在设置语言"))
        
        
        // 然后将设置好的语言存储好，下次进来直接加载
        
        UserDefaults.standard.set(language, forKey: "Think_Sharer_APP_Language")
        
        UserDefaults.standard.synchronize()
        
    
        self.tableView.reloadData()
        
        self.setNavigationBarTitle(NSLocalizedString("Language Settings", comment: ""))

    }

}
