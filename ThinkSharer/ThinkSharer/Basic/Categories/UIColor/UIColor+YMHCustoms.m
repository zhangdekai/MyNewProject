//
//  UIColor+YMHCustoms.m
//  CoreFrame
//
//  Created by wangguangfeng on 15/10/18.
//  Copyright © 2015年 Beijing Yimay Holiday Information Science & Technology Co.,Ltd. All rights reserved.
//

#import "UIColor+YMHCustoms.h"

@implementation UIColor (YMHCustoms)

+ (UIColor *)mainColor {
    return [UIColor ymh_colorWithHex:0xa6b886];

}

#pragma mark - font color
+ (UIColor *)generalFontWhiteColor
{
    return [UIColor ymh_colorWithHex:0xffffff];
}

+ (UIColor *)generalFontOrangeColor
{
    return [UIColor ymh_colorWithHex:0xff9933];
}

+ (UIColor *)generalFontRedColor
{
    return [UIColor ymh_colorWithHex:0xfa4619];
}

+ (UIColor *)generalFontRedColorWithAlpha :(CGFloat)alpha
{
    return [UIColor ymh_colorWithHex:0xfa4619 alpha:alpha];
}

+ (UIColor *)generalTitleFontBlackColor
{
    return [UIColor ymh_colorWithHex:0x333333];
}

+ (UIColor *)generalTitleFontGrayColor
{
    return [UIColor ymh_colorWithHex:0x666666];
}

+ (UIColor *)generalSubTitleFontGrayColor
{
    return [UIColor ymh_colorWithHex:0x999999];
}

/**
 *  background colors
 */
+ (UIColor *)backgroundRedColor
{
    return [UIColor ymh_colorWithHex:0xfa4619];
}

+ (UIColor *)backgroundGrayColorA
{
    return [UIColor ymh_colorWithHex:0xfafafa];
}

+ (UIColor *)backgroundGrayColorB
{
    return [UIColor ymh_colorWithHex:0xf4f4f4];
}

/**
 *  assistant colors
 */

+ (UIColor *)assistantOrangeColor
{
    return [UIColor ymh_colorWithHex:0xff9933];
}
+ (UIColor *)assistantRedColor
{
    return [UIColor ymh_colorWithHex:0xf56b6e];
}
+ (UIColor *)assistantGreenColor
{
    return [UIColor ymh_colorWithHex:0x29bf96];
}
+ (UIColor *)assistantblueColor
{
    return [UIColor ymh_colorWithHex:0x67aef1];
}
+ (UIColor *)assistantGrayColor
{
    return [UIColor ymh_colorWithHex:0xcccccc];
}

/**
 *  seperate colors
 */
+ (UIColor *)seperateThickLineColor
{
    return [UIColor ymh_colorWithHex:0xf4f4f4];
}

+ (UIColor *)seperateThinLineColor
{
    return [UIColor ymh_colorWithHex:0xe1e1e1];
}

#pragma mark - icon and label colors
+ (UIColor *)generalWarmColor
{
    return [UIColor ymh_colorWithHex:0xff922b];
}

+ (UIColor *)generalCoolColor;
{
    return [UIColor ymh_colorWithHex:0xdbdfe2];
}

+ (UIColor *)smallIconColor
{
    return [UIColor ymh_colorWithHex:0xdddddd];
}

+ (UIColor *)bigIconColor
{
    return [UIColor ymh_colorWithHex:0xe5e5e5];
}

+ (UIColor *)imageBackgroundColor
{
    return [UIColor ymh_colorWithHex:0xdddddd];
}

+ (UIColor *)navigationBarTitleTextColor
{
    return [UIColor ymh_colorWithHex:0x666666];
}

+ (UIColor *)navigationBarBackgroundColor
{
    return [UIColor ymh_colorWithHex:0xffffff];
}

+ (UIColor *)navigationBarBackgroundColorWithAlph
{
    return [UIColor ymh_colorWithHex:0xffffff alpha:0.9];
}

#pragma mark - seperate line
+ (UIColor *)seperateLineColor {
    return [UIColor ymh_colorWithHex:0xdbdfe2];
}

#pragma mark - 登陆界面
+ (UIColor *)loginButtonCanNotUseColor {
    return [UIColor colorWithRed:250/255.0 green:70/255.0 blue:25/255.0 alpha:0.75];
}
+ (UIColor *)loginButtonCanUseColor {
    return [UIColor colorWithRed:250/255.0 green:70/255.0 blue:25/255.0 alpha:1];
}

@end
