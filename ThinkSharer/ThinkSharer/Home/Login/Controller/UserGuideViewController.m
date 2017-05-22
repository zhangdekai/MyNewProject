//
//  UserGuideViewController.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/22.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "UserGuideViewController.h"

@interface UserGuideViewController ()

@end

@implementation UserGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBar];
}

- (void)setNavigationBar {
    [self setNavigationBarTitle:@"用户手册"];
    TSWeakSelf
    [self setNavigationBarLeftItemWithImageName:@"navigation_back" itemBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
