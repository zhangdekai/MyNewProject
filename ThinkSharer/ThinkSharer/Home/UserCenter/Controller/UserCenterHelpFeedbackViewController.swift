//
//  UserCenterHelpFeedbackViewController.swift
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/7.
//  Copyright © 2017年 张德凯. All rights reserved.
//

import UIKit

class UserCenterHelpFeedbackViewController: BasicViewController {

    var tableView:UITableView!
    let cellDataSource = [NSLocalizedString("视频中心", comment: "视频中心"),
                          NSLocalizedString("使用手册", comment: "使用手册"),
                          NSLocalizedString("常见问题", comment: "常见问题"),
                          NSLocalizedString("角色体验", comment: "角色体验"),
                          NSLocalizedString("客服咨询", comment: "客服咨询")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setNavigationBarBack()
        self.setNavigationBarTitle(NSLocalizedString("Help and feedback", comment: ""))
        initilizeUI()
    }
    private lazy var tableHeaderView: UserHelpAndFeedbackTableHeaderView = {
        let view = UserHelpAndFeedbackTableHeaderView(frame: CGRect.zero)
        view.headerBlock = {[weak self](index:Int) in
            guard let `self` = self else {return}
            switch index {
            case 0:
                print(index)
                let vc = UserCustomServiceViewController(nibName: "UserCustomServiceViewController",
                                                         bundle: Bundle.main)
                self.navigationController?.pushViewController(vc, animated: true)
                break
            case 1:
                print(index)
                break
            case 2:
                print(index)
                let vc = UserFeedbackViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                break
            case 3:
                print(index)
                break
                
            default:
                break
            }
        }
        return view
    }()
    func initilizeUI() {
        tableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight),
                                style: UITableViewStyle.plain)
        self.view.addSubview(tableView)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserHelpFeedbackCell.self, forCellReuseIdentifier: "UserHelpFeedbackCell")
        tableView.tableHeaderView = tableHeaderView
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension UserCenterHelpFeedbackViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserHelpFeedbackCell")as!UserHelpFeedbackCell
        
        cell.helpLabel.text = cellDataSource[indexPath.row]
       
        return cell
        
    }
    
  
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
    }
    
}
