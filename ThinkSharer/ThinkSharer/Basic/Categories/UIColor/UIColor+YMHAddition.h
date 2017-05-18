//
//  UIColor+YMHAddition.h
//  CoreFrame
//
//  Created by wangguangfeng on 15/10/18.
//  Copyright © 2015年 Beijing Yimay Holiday Information Science & Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (YMHAddition)

+ (UIColor *)ymh_colorWithHex:(int)hex;
+ (UIColor *)ymh_colorWithHex:(int)hex alpha:(CGFloat)alpha;
+ (UIColor *)ymh_colorWithHexString:(NSString *)hexString;

@end
