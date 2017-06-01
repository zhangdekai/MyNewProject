//
//  ShareMessageTableHeaderView.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/24.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "ShareMessageTableHeaderView.h"

@implementation ShareMessageTableHeaderView


- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.frame = CGRectMake(0, 0, ScreenWidth, 400);
        self.backgroundColor = [UIColor whiteColor];
        
        //头像
        _headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
        
        [self addSubview:_headerImageView];
        
        _headerImageView.userInteractionEnabled = YES;

        _headerImageView.image = [UIImage imageNamed:@"testHeader"];
        
        //相机icon
        _camerIcon = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - 50 , 170, 25, 25)];
        
        [_headerImageView addSubview:_camerIcon];
        
        _camerIcon.image = [UIImage imageNamed:@"user_fenxiang"];
        
        _camerIcon.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMethod:)];
        
        [_camerIcon addGestureRecognizer:tap];
        
        
        //昵称
        
        UILabel *nickName = [[UILabel alloc]initWithFrame:CGRectMake(15, _headerImageView.bottom + 15 + 10, 90, 20)];
        [self addSubview:nickName];
        
        nickName.textColor = [UIColor generalTitleFontBlackColor];
        
        nickName.font = [UIFont systemFontOfSize:17];
        
        nickName.text = @"昵称";
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, _headerImageView.bottom, ScreenWidth, 15)];
        [self addSubview:line];
        line.backgroundColor = [UIColor backgroundGrayColorA];
        
        
        _nickTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(nickName.right +15, nickName.top, ScreenWidth - nickName.right - 30, 30)];
        [self addSubview:_nickTextFiled];
        _nickTextFiled.textAlignment = NSTextAlignmentRight;
        _nickTextFiled.placeholder = @"填写昵称";
        
        _nickLine = [[UIView alloc]initWithFrame:CGRectMake(0, nickName.bottom + 10, ScreenWidth, 0.5)];
        [self addSubview:_nickLine];
        _nickLine.backgroundColor = [UIColor seperateThinLineColor];

        
        //性别
        
        UILabel *sexLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, _nickLine.bottom + 10, 90, 20)];
        [self addSubview:sexLabel];
        sexLabel.textColor = [UIColor generalTitleFontBlackColor];
        sexLabel.font = [UIFont systemFontOfSize:17];
        sexLabel.text = @"性别";

        UIButton *sexButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - 100, sexLabel.top, 40, 20)];
        [self addSubview:sexButton];
        [sexButton setTitle:@"女" forState:(UIControlStateNormal)];
        [sexButton setTitleColor:[UIColor generalTitleFontBlackColor] forState:(UIControlStateNormal)];
        sexButton.tag = 100;
        sexButton.titleLabel.font = [UIFont systemFontOfSize:15];
        UIImageView *iconGirl = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
        iconGirl.image = [UIImage imageNamed:@"user_icon-girl"];
        [sexButton addSubview:iconGirl];
        
        [sexButton setContentEdgeInsets:(UIEdgeInsetsMake(0, 15, 0, 0))];
        
        
        UIButton *sexButtonBoy = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - 60, sexLabel.top, 40, 20)];
        [self addSubview:sexButtonBoy];
        [sexButtonBoy setTitle:@"男" forState:(UIControlStateNormal)];
        [sexButtonBoy setTitleColor:[UIColor generalTitleFontBlackColor] forState:(UIControlStateNormal)];
        sexButtonBoy.titleLabel.font = [UIFont systemFontOfSize:15];

        UIImageView *iconBoy = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
        iconBoy.image = [UIImage imageNamed:@"user_icon-boy"];
        [sexButtonBoy addSubview:iconBoy];
        [sexButtonBoy setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentLeft)];
        [sexButtonBoy setContentEdgeInsets:(UIEdgeInsetsMake(0, 15, 0, 0))];

        UIView *sexLine = [[UIView alloc]initWithFrame:CGRectMake(0, sexLabel.bottom + 10, ScreenWidth, 0.5)];
        [self addSubview:sexLine];
        sexLine.backgroundColor = [UIColor seperateThinLineColor];
        sexButtonBoy.tag = 101;

        //出生日期
        
        UILabel *birthday = [[UILabel alloc]initWithFrame:CGRectMake(15, sexLine.bottom + 10, 90, 20)];
        [self addSubview:birthday];
        birthday.textColor = [UIColor generalTitleFontBlackColor];
        birthday.font = [UIFont systemFontOfSize:17];
        birthday.text = @"出生日期";

         _birthdayButton = [[UIButton alloc]initWithFrame:CGRectMake(birthday.right, birthday.top, ScreenWidth - birthday.right - 15, 20)];
        [self addSubview:_birthdayButton];
        [_birthdayButton setTitle:@"请选择" forState:(UIControlStateNormal)];
        [_birthdayButton setTitleColor:[UIColor generalTitleFontBlackColor] forState:(UIControlStateNormal)];
        _birthdayButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_birthdayButton setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentRight)];

      
        UIView *birthdayLine = [[UIView alloc]initWithFrame:CGRectMake(0, birthday.bottom + 10, ScreenWidth, 0.5)];
        [self addSubview:birthdayLine];
        birthdayLine.backgroundColor = [UIColor seperateThinLineColor];
        
        
        [sexButton addTarget:self action:@selector(sexButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [sexButtonBoy addTarget:self action:@selector(sexButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];

        
        [_birthdayButton addTarget:self action:@selector(birthdayButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
        
        
        //思享者简介
        
        
        UILabel *introLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, birthdayLine.bottom + 10, 90, 20)];
        [self addSubview:introLabel];
        introLabel.textColor = [UIColor generalTitleFontBlackColor];
        introLabel.font = [UIFont systemFontOfSize:17];
        introLabel.text = @"思享者简介";
        
        _introButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - 40, introLabel.top, 15, 15)];
        [self addSubview:_introButton];
        [_introButton setImage:[UIImage imageNamed:@"login_x"] forState:(UIControlStateNormal)];
 
        
        //textView
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(15, _introButton.bottom + 10, ScreenWidth - 30, 30)];
        [self addSubview:_textView];
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.layer.borderWidth = 1;
        _textView.layer.borderColor = [UIColor blackColor].CGColor;
        
        
        _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth - 60, 15, 25, 15)];
        [_textView addSubview:_numLabel];
        _numLabel.text = @"100";

        
        
        


    }
    return self;
}

- (void)setBirthdayString:(NSString *)birthday {
    [_birthdayButton setTitle:birthday forState:(UIControlStateNormal)];
}


- (void)tapMethod:(UITapGestureRecognizer *)tap {
    
    self.SelectPhotoBlock();
}

- (void)birthdayButtonClick {
    self.SelectBirthdatBlock();
}

- (void)sexButtonClick:(UIButton *)button {
    if (button.tag == 100) {
        
    }
    
}


@end
