//
//  TSAlterShowView.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/6.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "TSAlterShowView.h"

@interface TSAlterShowView ()

@property (nonatomic,strong) UIView *backHUD;
@property (nonatomic,strong) UIView *container;
@property (nonatomic,assign) CGFloat containerHeight;


@end

@implementation TSAlterShowView



- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor = [UIColor clearColor];
        
        _backHUD = [[UIView alloc]initWithFrame:self.bounds];
        _backHUD.backgroundColor = [UIColor blackColor];
        _backHUD.alpha = 0.3;
        [self addSubview:_backHUD];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMethod:)];
        _backHUD.userInteractionEnabled = YES;
        [_backHUD addGestureRecognizer:tap];
        
    }
    return self;
}


- (void)creatContainerView:(UIView *)container {
    
    _container = container;
    _containerHeight = container.frame.size.height;
    _container.frame = CGRectMake(0, ScreenHeight, ScreenWidth, _containerHeight);
    
    [self addSubview:_container];
}

- (void)showView {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        if (_container) {
            
            _container.frame = CGRectMake(0, ScreenHeight - _containerHeight , ScreenWidth, _containerHeight);
            
        }
        
    } completion:nil];
    
    
}


- (void)tapMethod:(UITapGestureRecognizer *)tap {
    [self hiddenAlter];
}

- (void)hiddenAlter {
    
    [UIView animateWithDuration:0.3 animations:^{
        _container.frame = CGRectMake(0, ScreenHeight, ScreenWidth, _containerHeight);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}



@end
