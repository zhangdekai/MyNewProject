//
//  TSPublicTool.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/17.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//可自行添加公共tool

@interface TSPublicTool : NSObject

//用于导航栏titleView
+ (UILabel *)initWithTitle:(NSString *)title;

+ (UILabel *)initWithTitle:(NSString *)title color:(UIColor*)color;

//按比例获得所需尺寸
+ (CGFloat)getRealPX:(CGFloat)px;

//每行显示3个，获取行数
+ (NSInteger)getRealCount:(NSInteger)count;

//一位数组转化为二维数组
+ (NSMutableArray *)convertArray:(NSMutableArray *)array;

@end
