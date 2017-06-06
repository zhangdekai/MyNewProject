//
//  UserLangageViewController.swift
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/6.
//  Copyright © 2017年 张德凯. All rights reserved.
//

import UIKit

class UserLangageViewController: BasicViewController {
    
    var tableView:UITableView!
    var languageSelectArray = [0,0,0,0,0]
    
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
        cell.selectStatsIndex = {[weak self](index:Int) in
            guard let `self` = self else {
                return
            }
            self.languageSelectArray[indexPath.row] = index
            self.tableView.reloadData()
        }
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

}
