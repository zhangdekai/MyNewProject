//
//  TSCustomTextFiled.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/19.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "TSCustomTextFiled.h"

@implementation TSCustomTextFiled

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


////控制清除按钮的位置
//-(CGRect)clearButtonRectForBounds:(CGRect)bounds
//{
//    return CGRectMake(bounds.origin.x + bounds.size.width - 50, bounds.origin.y + bounds.size.height -20, 16, 16);
//}

//控制placeHolder的位置，左右缩20
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    
    //return CGRectInset(bounds, 20, 0);
    CGRect inset = CGRectMake(bounds.origin.x, bounds.origin.y + (bounds.size.height / 5), bounds.size.width -10, bounds.size.height);//更好理解些
    return inset;
}
////控制显示文本的位置
//-(CGRect)textRectForBounds:(CGRect)bounds
//{
//    //return CGRectInset(bounds, 50, 0);
//    CGRect inset = CGRectMake(bounds.origin.x+190, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
//    
//    return inset;
//    
//}
////控制编辑文本的位置
//-(CGRect)editingRectForBounds:(CGRect)bounds
//{
//    //return CGRectInset( bounds, 10 , 0 );
//    
//    CGRect inset = CGRectMake(bounds.origin.x +10, bounds.origin.y, bounds.size.width -10, bounds.size.height);
//    return inset;
//}
////控制左视图位置
//- (CGRect)leftViewRectForBounds:(CGRect)bounds
//{
//    CGRect inset = CGRectMake(bounds.origin.x +10, bounds.origin.y, bounds.size.width-250, bounds.size.height);
//    return inset;
//    //return CGRectInset(bounds,50,0);
//}
//
////控制placeHolder的颜色、字体
//- (void)drawPlaceholderInRect:(CGRect)rect
//{
//    //CGContextRef context = UIGraphicsGetCurrentContext();
//    //CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
//    [[UIColor orangeColor] setFill];
//    [[self placeholder]drawInRect:rect withAttributes:[NSFontAttributeName:[UIFont systemFontOfSize:20]]];
//}


@end