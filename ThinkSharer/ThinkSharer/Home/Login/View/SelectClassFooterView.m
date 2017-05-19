//
//  SelectClassFooterView.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/17.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "SelectClassFooterView.h"

@implementation SelectClassFooterView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
        [self addSubview:line];
        line.backgroundColor = [UIColor backgroundGrayColorA];
    }
    return self;
}

@end
