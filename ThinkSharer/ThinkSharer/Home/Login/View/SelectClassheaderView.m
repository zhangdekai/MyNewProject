//
//  SelectClassheaderView.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/17.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "SelectClassheaderView.h"

@implementation SelectClassheaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    
    if (self) {
        
        UIView * line = [[UIView alloc]initWithFrame:CGRectMake(15, 15, 4, 15)];
        line.backgroundColor = [UIColor orangeColor];
        [self addSubview:line];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(line.right + 10, 13, 90, 20)];
        [self addSubview:label];

        label.tag = 100;
        label.font = [UIFont systemFontOfSize:17];
        label.textColor = [UIColor generalTitleFontBlackColor];

        
        UIView * line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 43.5, ScreenWidth , 0.5)];
        line1.backgroundColor = [UIColor seperateThinLineColor];
        [self addSubview:line1];
        
    }
    return self;
}


- (void)setHeaderTitle:(NSString *)title {
    UILabel *label = (UILabel *)[self viewWithTag:100];
    label.text = title;
}
@end
