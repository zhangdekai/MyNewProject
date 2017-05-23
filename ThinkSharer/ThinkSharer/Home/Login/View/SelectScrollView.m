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
        self.backgroundColor = [UIColor mainColorBlue];
        self.contentSize = CGSizeMake(ScreenWidth, 0);
        self.showsHorizontalScrollIndicator = false;
        self.showsVerticalScrollIndicator = false;
                
        NSInteger count = items.count;
        CGFloat backWidth = ScreenWidth / 7;
        
        if (count > 7) {
            self.contentSize = CGSizeMake(backWidth * count, 0);

        }
        

        for (int i = 0; i < count; i++) {
            
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(i * backWidth, 0, backWidth, 50)];
            [self addSubview:button];
            
            [button setTitle:items[i] forState:(UIControlStateNormal)];
            if (0 == i) {
                [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            } else {
                [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            }
            button.titleLabel.font = [UIFont systemFontOfSize:18];
            [button setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentCenter)];
            button.tag = 100 + i;
            
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        }
        
    }
    
    return self;
}

- (void)buttonClick:(UIButton *)button {
    NSInteger tag = button.tag - 100;
    [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];

    
    for (int i = 0; i < self.items.count; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:100 + i];
        if (tag != i) {
            [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        }
    }
    
    
    self.selectItem(self.items[tag]);
    
}

@end

