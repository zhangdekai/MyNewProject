//
//  UIColor+YMHCustoms.h
//  CoreFrame
//
//  Created by wangguangfeng on 15/10/18.
//  Copyright © 2015年 Beijing Yimay Holiday Information Science & Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (YMHCustoms)

/**
 *  main colors
 */
+ (UIColor *)mainColorGreen;//惨绿    0xa6b886



/**
 海蓝  0x57bdd4

 @return UIColor
 */
+ (UIColor *)mainColorBlue; //海蓝    0x57bdd4

+ (UIColor *)viewShaowColor; //阴影颜色 0x221815

/**
 *  font colors
 */
+ (UIColor *)generalFontWhiteColor;//主调白色 #ffffff
+ (UIColor *)generalFontOrangeColor;//主调橙色 #ff9933
+ (UIColor *)generalTitleFontBlackColor;//标题内容 #333333
+ (UIColor *)generalTitleFontGrayColor;//标题 #666666
+ (UIColor *)generalSubTitleFontGrayColor;//副标题 #999999
+ (UIColor *)generalFontRedColor;//主调红色 #fa4619
+ (UIColor *)generalFontRedColorWithAlpha :(CGFloat)alpha;//主调红色带Alpha

/**
 *  background colors
 */
+ (UIColor *)backgroundRedColor;//底色红 #fa4619
+ (UIColor *)backgroundGrayColorA;//底色A 0xfafafa
+ (UIColor *)backgroundGrayColorB;//底色B #f4f4f4

/**
 灰色C 0xe5e5e5

 @return UIColor
 */
+ (UIColor *)backgroundGrayColorC;
/**
 *  assistant colors
 */

+ (UIColor *)assistantOrangeColor;//辅助颜色#ff9933
+ (UIColor *)assistantRedColor;//辅助颜色#f56b6e
+ (UIColor *)assistantGreenColor;//辅助颜色#29bf96
+ (UIColor *)assistantblueColor;//辅助颜色#67aef1
+ (UIColor *)assistantGrayColor;//辅助颜色#cccccc

/**
 *  seperate colors
 */
+ (UIColor *)seperateThickLineColor;//粗分割线 #f4f4f4
+ (UIColor *)seperateThinLineColor;//细分割线 #eeeeee

/**
 *  icon and label colors
 */
+ (UIColor *)generalWarmColor;//暖色 #ff922b
+ (UIColor *)generalCoolColor;//冷色 #94d24d
+ (UIColor *)smallIconColor;//小图标 #dddddd
+ (UIColor *)bigIconColor;//大图标 #e5e5e5

+ (UIColor *)imageBackgroundColor;//#dddddd


+ (UIColor *)navigationBarTitleTextColor; // #636363 
+ (UIColor *)navigationBarBackgroundColor; //#ffffff
+ (UIColor *)navigationBarBackgroundColorWithAlph;

/**
 *  登陆界面
 */
+ (UIColor *)loginButtonCanUseColor;    //  fa4619
+ (UIColor *)loginButtonCanNotUseColor;

@end
