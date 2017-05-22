//
//  TSActionAlterView.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/22.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "TSActionAlterView.h"

@implementation TSActionAlterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor = [UIColor clearColor];
        
        _backHUD = [[UIView alloc]initWithFrame:self.bounds];
        _backHUD.backgroundColor = [UIColor clearColor];
        _backHUD.alpha = 0;
        [self addSubview:_backHUD];
        
    }
    return self;
}

- (void)creatActionAlterView:(NSString *)imageName rect:(CGRect)rect action:(AlterBlock)block {
    _actionBlock = block;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
    [self addSubview:imageView];
    imageView.image = [UIImage imageNamed:imageName];
    imageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [imageView addGestureRecognizer:tap];
    
    
}


- (void)showInView {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    
}

- (void)hiddenAlter {
    self.hidden = YES;
    [self removeFromSuperview];
}

- (void)tapAction:(UITapGestureRecognizer*)tap {
    self.actionBlock();
}


@end
