//
//  TSPublicTool.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/17.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "TSPublicTool.h"

@implementation TSPublicTool

+ (UILabel *)initWithTitle:(NSString *)title {
    
    UILabel *label = [[UILabel alloc]init];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    
    label.font = [UIFont systemFontOfSize:18];
    
    label.textColor = [UIColor generalTitleFontBlackColor];
    
    [label sizeToFit];
    
    label.center = CGPointMake(ScreenWidth * 0.5, 22);
    
    return label;
}


+ (UILabel *)initWithTitle:(NSString *)title color:(UIColor*)color {
    
    UILabel *label = [[UILabel alloc]init];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    
    label.font = [UIFont systemFontOfSize:15];
    
    label.textColor = color;
    
    [label sizeToFit];
    
    label.center = CGPointMake(ScreenWidth * 0.5, 22);
    
    return label;
    
}


+ (CGFloat)getRealPX:(CGFloat)px {
    
    CGFloat scle = ScreenWidth / 375.0;
    
    return px * scle;
}

+ (NSInteger)getRealCount:(NSInteger)count {
    
    NSInteger a = count / 3;
    if (a < 1) {
        return 1;
    }
    NSInteger b = count % 3;
    
    if (b > 0) {
        a += 1;
    }
    return a;
}


+ (NSMutableArray *)convertArray:(NSMutableArray *)array{
    
    NSInteger count = (array.count / 3);//行
    if (array.count > 0 && count == 0) {
        count = 1;
    } else {
        NSInteger arrayNum = array.count % 3;
        if (arrayNum != 0) {
            count += 1;
        }
    }
    
    NSInteger num = 0;
    NSMutableArray *twoArray = [NSMutableArray array];
    for (int i = 0 ; i < count; i++) {
        NSMutableArray *array1 = [NSMutableArray array];
        NSInteger num1 = i - (i - 1);
        
        for (int j = 0; j < 3; i++) {
            NSInteger num2 = j - (j - num1);
            if (num < array.count) {
                [array1 addObject:array[num]];
                
            } else {
                [array1 addObject:@""];
            }
            num += num2;
        }
        [twoArray addObject:array1];
    }
    
    return twoArray;

}


@end
