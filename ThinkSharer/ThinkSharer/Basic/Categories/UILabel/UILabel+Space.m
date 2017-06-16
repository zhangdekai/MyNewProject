//
//  UILabel+Space.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/16.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "UILabel+Space.h"

@implementation UILabel (Space)

+ (UILabel *)labelWithSpace:(CGFloat)space wordFont:(CGFloat)font
                 labelWidth:(CGFloat)width string:(NSString *)string {
    
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = [UIColor generalTitleFontBlackColor];
    
    label.numberOfLines = 0;
    
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:string];
    
    NSMutableParagraphStyle *paragraStyle = [[NSMutableParagraphStyle alloc]init];
    
    paragraStyle.lineSpacing = space;
    
    [attributeStr addAttribute:NSParagraphStyleAttributeName value:paragraStyle
                         range:NSMakeRange(0, string.length)];
    
    label.attributedText = attributeStr;
    [label sizeToFit];
    
    return label;
}


@end
