//
//  AccountSecureViewController.swift
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/5.
//  Copyright © 2017年 张德凯. All rights reserved.
//

import UIKit

let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height

class AccountSecureViewController: BasicViewController,UITextFieldDelegate {
    
    var tableView:UITableView!
    
    var mailTextFiled:UITextField!
    var mailLine:UIView!

    var passWordTextFiled:UITextField!
    var passWordAgainTextFiled:UITextField!
    var idnetityTextFiled:UITextField!
    var getIdentityButton:UIButton!
    
    var linkerTextFiled:UITextField!
    var linkerPhoneTextFiled:UITextField!


    private lazy var tableHeaderView: AccountSecurePhoneIdentityView = {
        
        let view = AccountSecurePhoneIdentityView(frame: CGRect.zero)
        view.changePhoneTextFiled.delegate = self
        view.identityTextfiled.delegate = self

        view.confirmBlock = {[weak self](_ phone:String, _ identity:String) in
            print(phone,identity)
            
        }
        view.getIdentityBlock = {[weak self](_ phone:String, _ button:UIButton) in
            guard let `self` = self else {return}
            YMHIdenCodeTool.idenCodeAction(with: button, controller: self, phoneNum: phone)
        }
        return view
    }()
    
    private lazy var tableFooterView: AccountTableFooterView = {
        
        let view = AccountTableFooterView(frame: CGRect.zero)
        
        return view
    }()
    
    //MARK: life style
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBarBack()
        self.setNavigationBarTitle("账号与安全")
        initilizeUI()
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    func keyBoardWillHidden() {
        tableView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
    }
    
    func initilizeUI() {
        tableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), style: UITableViewStyle.plain)
        self.view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountMailIdentityCell.self, forCellReuseIdentifier: "AccountMailIdentityCell")
        tableView.register(AccountPayPassCell.self, forCellReuseIdentifier: "AccountPayPassCell")
        tableView.register(AccountLinkerCell.self, forCellReuseIdentifier: "AccountLinkerCell")

        
        tableView.tableHeaderView = tableHeaderView
        tableView.tableFooterView = tableFooterView
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFiledDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == passWordTextFiled || textField == passWordAgainTextFiled  || textField == idnetityTextFiled {
            tableView.frame = CGRect(x: 0, y: -120, width: ScreenWidth, height: ScreenHeight)
        }
        
        if textField == linkerTextFiled || textField == linkerPhoneTextFiled {
            tableView.frame = CGRect(x: 0, y: -200, width: ScreenWidth, height: ScreenHeight)
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newstring = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        if textField == tableHeaderView.changePhoneTextFiled {
           
                if newstring.characters.count == 11 {
                    tableHeaderView.getIdentityButton.isEnabled = true
                    tableHeaderView.getIdentityButton.backgroundColor = UIColor.mainColorBlue()
                } else {
                    tableHeaderView.getIdentityButton.isEnabled = false
                    tableHeaderView.getIdentityButton.backgroundColor = UIColor.backgroundGrayColorC()
                }
                return true

        }  else if textField == passWordAgainTextFiled {
            
                if newstring.characters.count == 6 && newstring == (passWordTextFiled.text ?? ""){
                    getIdentityButton.isEnabled = true
                    getIdentityButton.backgroundColor = UIColor.mainColorBlue()
                } else {
                    getIdentityButton.isEnabled = false
                    getIdentityButton.backgroundColor = UIColor.backgroundGrayColorC()

                }
                return true
        }
        return true
        
    }
    
    
}
extension AccountSecureViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100

        } else if indexPath.section == 1 {
            return 200
        } else {
            return 150

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountMailIdentityCell")as!AccountMailIdentityCell
            
            mailLine = cell.mailLine
            mailTextFiled = cell.mailTextFiled
            mailTextFiled.delegate = self
            
            cell.confirmBlock = {[weak self](mail:String) in
                guard let `self` = self else {
                    return
                }
                if YMHRegularExpression.validateEmail(mail) {
                    
                } else {
                    self.showHud(withTextOnly: "请检查邮箱格式")
                }
                print(mail)
            }
            
            return cell
        } else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountPayPassCell")as!AccountPayPassCell
            
            passWordTextFiled = cell.passWordTextFiled
            passWordAgainTextFiled = cell.passWordAgainTextFiled
            idnetityTextFiled = cell.identityTextFiled
            getIdentityButton = cell.getIdentityButton
            passWordAgainTextFiled.delegate = self
            passWordTextFiled.delegate = self
            idnetityTextFiled.delegate = self

            cell.confirmBlock = {[weak self](_ payPassWord:String, _ idnetity:String) in
                
                print(payPassWord,idnetity)
            }
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountLinkerCell")as!AccountLinkerCell
            linkerTextFiled = cell.linkerTextFiled
            linkerPhoneTextFiled = cell.linkerPhoneTextFiled
            
            linkerPhoneTextFiled.delegate = self
            linkerTextFiled.delegate = self
            
            cell.confirmBlock = {[weak self](name:String, phoneString:String) in
                guard let `self` = self else {
                    return
                }
                print(name,phoneString)
            }
            return cell
            

        }
        
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
//NSRange转化为range
extension String {
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
}
