//
//  ClassSearchClassTimeView.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/15.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "ClassSearchClassTimeView.h"

@interface ClassSearchClassTimeView ()

@property (nonatomic,strong) UILabel *dataLabel;
@property (nonatomic,strong) UILabel *dataLabel1;

@property (nonatomic,strong) UILabel *weekLabel;
@property (nonatomic,strong) UILabel *weekLabel1;

@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *timeLabel1;

@property (nonatomic,strong) UILabel *hourLabel;

@property (nonatomic,strong) UIButton *startButton;
@property (nonatomic,strong) UIButton *endButton;


@end

@implementation ClassSearchClassTimeView

-(instancetype)init {
    self = [super init];
    if (self) {
        
        _dataLabel = [self sectionView:@"2017-03-12"];
        [self addSubview:_dataLabel];
        
        _dataLabel1 = [self sectionView:@"2017-03-12"];
        [self addSubview:_dataLabel1];

        _weekLabel = [self sectionView:@"周六"];
        [self addSubview:_weekLabel];
        
        _weekLabel1 = [self sectionView:@"周六"];
        [self addSubview:_weekLabel1];
        
        _timeLabel = [self sectionView:@"19:20"];
        [self addSubview:_timeLabel];
        
        _timeLabel1 = [self sectionView:@"20:20"];
        [self addSubview:_timeLabel1];
        
        _hourLabel = [self sectionView:@"1小时"];
        [self addSubview:_hourLabel];
   
        _startButton = [self commonButton:@"开始"];
        [self addSubview:_startButton];
        [_startButton addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        _endButton = [self commonButton:@"结束"];
        _startButton.tag = 100;
        [self addSubview:_endButton];
        [_endButton addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        _endButton.tag = 101;

        [self setViewFrame];
    }
    return self;
}

- (void)buttonClick:(UIButton *)button {
    if (button.tag == 100) {
        if (self.startOrEndBlock) {
            self.startOrEndBlock(0);
        }
    } else {
        if (self.startOrEndBlock) {
            self.startOrEndBlock(1);
        }
    }
}

- (void)setViewFrame {
    CGFloat gap = 15;
    CGFloat dateW = [TSPublicTool getRealPX:100];
    CGFloat dateH = 20;
    CGFloat weekW = [TSPublicTool getRealPX:50];

    
    _dataLabel.frame = CGRectMake(gap, 0, dateW, dateH);
    _dataLabel1.frame = CGRectMake(gap, _dataLabel.bottom + 15, dateW, dateH);
    
    _weekLabel.frame = CGRectMake(_dataLabel.right + 20, 0, weekW, 20);
    _weekLabel1.frame = CGRectMake(_dataLabel.right + 20, _weekLabel.bottom + 15, weekW, 20);
    
    _timeLabel.frame = CGRectMake(_weekLabel.right + 30, 0, weekW, 20);
    _timeLabel1.frame = CGRectMake(_weekLabel.right + 30, _timeLabel.bottom + 15, weekW, 20);
    _startButton.frame = CGRectMake(ScreenWidth - 55, 0, 40, 20);
    _endButton.frame = CGRectMake(ScreenWidth - 55, _startButton.bottom + 15, 40, 20);
    
    _hourLabel.frame = CGRectMake(_weekLabel.right, _weekLabel.bottom, 50, 20);

}

- (void)setStartTime:(NSArray *)timeArray {
    if (timeArray.count == 3) {
        _dataLabel.text = timeArray[0];
        _weekLabel.text = timeArray[1];
        _timeLabel.text = timeArray[2];
    }
}

- (void)setEndTime:(NSArray *)timeArray {
    if (timeArray.count == 3) {
        _dataLabel1.text = timeArray[0];
        _weekLabel1.text = timeArray[1];
        _timeLabel1.text = timeArray[2];
    }
}

- (void)setHourTime:(NSString *)hour {
    _hourLabel.text = hour;
}


- (UILabel *)sectionView:(NSString *)title {
    UILabel *section = [[UILabel alloc]init];
    section.textColor = [UIColor generalTitleFontGrayColor];
    section.font = [UIFont systemFontOfSize:15];
    section.text = title;
    return section;
}

- (UIButton *)commonButton:(NSString *)title {
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:title forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor mainColorBlue] forState:(UIControlStateNormal)];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    
    return button;
}


@end
