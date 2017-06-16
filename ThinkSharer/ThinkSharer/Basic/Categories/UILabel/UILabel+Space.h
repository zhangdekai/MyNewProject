//
//  UILabel+Space.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/16.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UILabel (Space)


/**
 带行间距的label

 @param space 间距
 @param font 字体
 @param width label 宽度
 @param string string
 @return UILabel
 */
+ (UILabel *)labelWithSpace:(CGFloat)space wordFont:(CGFloat)font
                 labelWidth:(CGFloat)width string:(NSString *)string;

@end
