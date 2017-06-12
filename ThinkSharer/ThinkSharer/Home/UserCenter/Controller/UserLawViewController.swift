//
//  UserLawViewController.swift
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/9.
//  Copyright © 2017年 张德凯. All rights reserved.
//

import UIKit

class UserLawViewController: BasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setNavigationBarBack()
        self.setNavigationBarTitle(NSLocalizedString("法律信息", comment: ""))
        // Do any additional setup after loading the view.
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
