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
    
    label.font = [UIFont systemFontOfSize:18];
//    label.font = [UIFont boldSystemFontOfSize:18];

    
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
    
    NSMutableArray *twoArray = [NSMutableArray array];
    NSMutableArray *origenArray  = [NSMutableArray arrayWithArray:array];
    NSInteger origenNum = array.count;
    

    for (int i = 0 ; i < count; i++) {
        if (origenNum == 0) {
            break;
        }
        
        NSLog(@"twoArray  %@",twoArray);
        NSMutableArray *array1 = [NSMutableArray array];

        for (int j = 0; j < 3; j++) {
            if (j >= origenNum) {
                [array1 addObject:@""];
            } else {
                [array1 addObject:origenArray[j]];
            }
            
        }
        
        [twoArray addObject:array1];
        
        for (int k = 0; k < 3; k++) {
            if (k < origenNum) {
                [origenArray removeObjectAtIndex:0];
            }
        }
        origenNum = origenArray.count;
                
    }
    NSLog(@"twoArray  %@",twoArray);

    return twoArray;

}


+ (TSActionAlterView *)shareInstance {
    static TSActionAlterView *shareView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareView = [[TSActionAlterView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        
    });
    return shareView;
}


/**
 *  自适应字体
 */
+ (CGSize)sizeWithString:(NSString*)string font:(UIFont*)font width:(CGFloat)width {
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width,   80000) options:NSStringDrawingTruncatesLastVisibleLine |   NSStringDrawingUsesFontLeading    |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size;
}

@end
