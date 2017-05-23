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
        _backHUD.backgroundColor = [UIColor blackColor];
        _backHUD.alpha = 0.3;
        [self addSubview:_backHUD];
        
    }
    return self;
}

- (void)creatActionAlterView:(NSString *)imageName size:(CGSize)size action:(AlterBlock)block {
    _actionBlock = block;
    
    _startImageView = [[UIImageView alloc]init];
    [self addSubview:_startImageView];
    
//    imageView.size = size;
//    imageView.centerX = self.centerX;
//    imageView.bottom = 125;
    _startImageView.clipsToBounds = YES;
    [_startImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.equalTo(self.mas_bottom).offset(-125);
        
    }];
    
    _startImageView.image = [UIImage imageNamed:imageName];
    _startImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [_startImageView addGestureRecognizer:tap];
    
    
}

- (void)addSecondAlter {
    UIImageView *imageView = [[UIImageView alloc]init];
    [self addSubview:imageView];
    
    //    imageView.size = size;
    //    imageView.centerX = self.centerX;
    //    imageView.bottom = 125;
    imageView.clipsToBounds = YES;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.equalTo(self.mas_top).offset(130);
        
    }];
    
    imageView.image = [UIImage imageNamed:@"map_goList"];
    imageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction1:)];
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
//    [self hiddenAlter];
    [_startImageView removeFromSuperview];
    [self addSecondAlter];
//    self.actionBlock();
}

- (void)tapAction1:(UITapGestureRecognizer*)tap {
    [self hiddenAlter];
//    self.actionBlock();
}




@end
