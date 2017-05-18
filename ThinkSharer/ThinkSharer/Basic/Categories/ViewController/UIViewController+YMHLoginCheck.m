//
//  UIViewController+YMHLoginCheck.m
//  CoreFrame
//
//  Created by Azen.Xu on 15/12/10.
//  Copyright © 2015年 Beijing Yimay Holiday Information Science & Technology Co.,Ltd. All rights reserved.
//

#import "UIViewController+YMHLoginCheck.h"

@implementation UIViewController (YMHLoginCheck)

- (void)checkLoginAndThen:(YMHCheckLoginSuccessful)successfulBlock
{
//    if ([[YMHAccountManager shareInstance] userLoginStatus])    //  已登录
//    {
//        if (successfulBlock)
//        {
//            successfulBlock();
//        }
//    }
//    else    //  未登录
//    {
//        [YMHLoginViewController showLoginControllerFromController:self showStyle:YMHShowLoginControllerStyleModal callBack:^(BOOL isSuccessful) {
//            if (isSuccessful)
//            {
//                if (successfulBlock)
//                {
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        successfulBlock();
//                    });
//                }
//            }
//        }];
//    }
}


@end
