//
//  PersonalOrCompanyView.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/4.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "PersonalOrCompanyView.h"

@implementation PersonalOrCompanyView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor = [UIColor clearColor];
        
        _backHUD = [[UIView alloc]initWithFrame:self.bounds];
        _backHUD.backgroundColor = [UIColor blackColor];
        _backHUD.alpha = 0.3;
        [self addSubview:_backHUD];
        [self creatActionAlterView];
        
    }
    return self;
}

- (void)creatActionAlterView {
    
    UIView *backView = [[UIView alloc]init];
    
    [self addSubview:backView];
    backView.backgroundColor = [UIColor whiteColor];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(300, 230));
        
    }];
    
    //个人
    UIButton *person = [[UIButton alloc]init];
    [backView addSubview:person];
    
    [person mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView.mas_top).offset(60);
        make.centerX.mas_equalTo(backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(180, 44));
    }];
    
    [person setTitle:@"个人" forState:(UIControlStateNormal)];
    person.tag = 100;
    person.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [person setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [person setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentCenter)];
    [person addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [person setBackgroundColor:[UIColor mainColorBlue]];
    person.layer.masksToBounds = YES;
    person.layer.cornerRadius = 5;

    //机构
    UIButton *company = [[UIButton alloc]init];
    [backView addSubview:company];
    
    [company mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(person.mas_bottom).offset(21);
        make.centerX.mas_equalTo(backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(180, 44));
    }];
    [company setBackgroundColor:[UIColor mainColorBlue]];

    [company setTitle:@"机构" forState:(UIControlStateNormal)];
    company.tag = 101;
    company.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [company setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [company setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentCenter)];
    [company addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    company.layer.masksToBounds = YES;
    company.layer.cornerRadius = 5;



    
}

- (void)buttonClick:(UIButton *)button {
    if (button.tag == 100) {
        self.SelectPersonOrCompany(0);
    } else {
        self.SelectPersonOrCompany(1);
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

@end
