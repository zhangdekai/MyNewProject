//
//  SearchClassResultView.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/15.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "SearchClassResultView.h"

@interface SearchClassResultView ()

@property (nonatomic,copy) void(^searchResult)();

@property (nonatomic,strong) UIView *backHUD;
@property (nonatomic,strong) UIImageView *startImageView;


@end

@implementation SearchClassResultView

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
        _backHUD.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self action:@selector(tapAction:)];
        [_backHUD addGestureRecognizer:tap];
    }
    return self;
}

- (void)creatActionAlterView:(NSString *)titleString action:(void(^)())block {
    self.searchResult = block;
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth - 40, 350));
        
    }];
    backView.layer.cornerRadius = 5;
    backView.layer.masksToBounds = YES;
    
    
    UIImageView *closeImage = [[UIImageView alloc]init];
    [backView addSubview:closeImage];
    
    [closeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    closeImage.userInteractionEnabled = YES;
    closeImage.image = [UIImage imageNamed:@"login_x"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [closeImage addGestureRecognizer:tap];
    
    //灯
    UIImageView *lightImage = [[UIImageView alloc]init];
    [backView addSubview:lightImage];
    
    [lightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(30);
        make.size.mas_equalTo(CGSizeMake(20, 25));
    }];
    
    lightImage.userInteractionEnabled = YES;
    lightImage.image = [UIImage imageNamed:@"testHeader"];
    
    UILabel *midelLabel = [UILabel labelWithSpace:8 wordFont:17 labelWidth:backView.width - 50
                                            string:titleString];
    [backView addSubview:midelLabel];
    
    [midelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.equalTo(lightImage.mas_bottom).offset(30);
        make.left.mas_equalTo(25);
        make.size.mas_equalTo(CGSizeMake(backView.width - 50 , 80));
    }];
//    midelLabel.text = titleString;
//    midelLabel.textColor = [UIColor blackColor];
//    midelLabel.font = [UIFont systemFontOfSize:18];
//    midelLabel.numberOfLines = 0;
//    [midelLabel sizeToFit];
    
    UIButton *button = [[UIButton alloc]init];
    [backView addSubview:button];
    [button setTitle:@"立即订制" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    button.backgroundColor = [UIColor mainColorBlue];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.equalTo(backView.mas_bottom).offset(-30);
        make.left.mas_equalTo(25);
        make.size.mas_equalTo(CGSizeMake(150 , 44));
    }];
    
    [button addTarget:self action:@selector(butotnClick) forControlEvents:(UIControlEventTouchUpInside)];
}


- (void)butotnClick {
    if (self.searchResult) {
        self.searchResult();
    }
    [self hiddenAlter];
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
    [self hiddenAlter];

}

- (void)tapAction1:(UITapGestureRecognizer*)tap {
    [self hiddenAlter];

}



@end
