//
//  SelectScrollView.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/17.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "SelectScrollView.h"

@implementation SelectScrollView



- (instancetype)initWithFrame:(CGRect)frame selectItems:(NSMutableArray *)items {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.items = items;
        self.backgroundColor = [UIColor whiteColor];
        self.contentSize = CGSizeMake(ScreenWidth, 0);
        self.showsHorizontalScrollIndicator = false;
        self.showsVerticalScrollIndicator = false;
                
        NSInteger count = items.count;
        CGFloat backWidth = (ScreenWidth - 15) / 7;
        
        if (count > 7) {
            self.contentSize = CGSizeMake(backWidth * count, 0);

        }
        
       

        for (int i = 0; i < count; i++) {
            
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake( 15 + i * backWidth, 0, backWidth, 47)];
            [self addSubview:button];
            
            [button setTitle:items[i] forState:(UIControlStateNormal)];
            if (0 == i) {
                [button setTitleColor:[UIColor mainColorBlue] forState:(UIControlStateNormal)];
            } else {
                [button setTitleColor:[UIColor generalTitleFontBlackColor] forState:(UIControlStateNormal)];
            }
            button.titleLabel.font = [UIFont systemFontOfSize:17];
            [button setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentLeft)];
            button.tag = 100 + i;
            
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        }
        
        _blueLine = [[UIView alloc]initWithFrame:CGRectMake(15, 47, backWidth, 3)];
        _blueLine.backgroundColor = [UIColor whiteColor];
        [self addSubview:_blueLine];
        
        UILabel *blueLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, backWidth - 20, 3)];
        [_blueLine addSubview:blueLine];
        blueLine.backgroundColor = [UIColor mainColorBlue];
        
    }
    
    return self;
}

- (void)buttonClick:(UIButton *)button {
    NSInteger tag = button.tag - 100;
    [button setTitleColor:[UIColor mainColorBlue] forState:(UIControlStateNormal)];

    CGFloat backWidth = (ScreenWidth - 15) / 7;

    [UIView animateWithDuration:0.3 animations:^{
        _blueLine.frame = CGRectMake(15 + tag * backWidth, 47, backWidth, 3);
    }];
    
    for (int i = 0; i < self.items.count; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:100 + i];
        if (tag != i) {
            [btn setTitleColor:[UIColor generalTitleFontBlackColor] forState:(UIControlStateNormal)];
        }
    }
    
    
    self.selectItem(self.items[tag]);
    
}

@end

