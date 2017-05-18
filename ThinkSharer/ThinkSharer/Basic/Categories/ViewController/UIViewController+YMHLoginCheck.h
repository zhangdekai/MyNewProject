//
//  UIViewController+YMHLoginCheck.h
//  CoreFrame
//
//  Created by Azen.Xu on 15/12/10.
//  Copyright © 2015年 Beijing Yimay Holiday Information Science & Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YMHCheckLoginSuccessful)();

@interface UIViewController (YMHLoginCheck)

- (void)checkLoginAndThen :(YMHCheckLoginSuccessful)successfulBlock;

@end
