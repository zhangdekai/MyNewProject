//
//  ClassSearchViewController.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/15.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "ClassSearchViewController.h"
#import "ClassSearchClassTimeView.h"

/**
 搜索课程
 */

@interface ClassSearchViewController ()<UIScrollViewDelegate,UITextViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic,strong) ClassSearchClassTimeView *timeView;
@property (nonatomic,strong) TSCustomTextFiled *priceTextFiled;
@property (nonatomic,strong) TSCustomTextFiled *priceTextFiled1;
@property (nonatomic,strong) UITextView        *placTextView;
@property (nonatomic,strong) UISwitch          *selectView;
@property (nonatomic,strong) UILabel           *placeLabel;

@property (nonatomic,assign) NSTimeInterval startTime;
@property (nonatomic,assign) NSTimeInterval endTime;


@end

@implementation ClassSearchViewController


#pragma mark - View Controller LifeCyle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialNavigationBar];
    [self initilizeUI];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = [UIColor mainColorBlue];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Initial Methods

- (void)initialNavigationBar {

    [self setNavigationBarBack:[UIImage imageNamed:@"navigation_back"]];
    [self setNavigationBarTitle:@"搜索课程" titleColor:[UIColor whiteColor]];
    [self setBarRightItemWithTitle:@"确定" textColor:[UIColor whiteColor] itemBlock:^{
        NSLog(@"");
    }];
}

- (void)initilizeUI {
    [self.view addSubview:self.scrollView];
    
    CGFloat gap = 15;
    CGFloat buttonW = [TSPublicTool getRealPX:(ScreenWidth - 30 - 100) / 3];
    CGFloat buttonH = 30;
    CGFloat frameH = 0;
    //讲师性别
    UILabel *teachsexLabel = [self sectionView:@"讲师性别"];
    [_scrollView addSubview:teachsexLabel];
    teachsexLabel.frame = CGRectMake(15, 15, 120, 20);

    
    NSArray *sexs = @[@"不限",@"男",@"女"];
    for (int i = 0; i < 3; i++) {
        UIButton *sexButton = [self commonButton:sexs[i]];
        [_scrollView addSubview:sexButton];
        sexButton.frame = CGRectMake(gap + i * (buttonW + 50), teachsexLabel.bottom +15, buttonW, buttonH);
        sexButton.tag = 100 + i;
        [sexButton addTarget:self action:@selector(sexButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        if (i == 2) {
            frameH = sexButton.bottom;
        }
        if (i == 0) {
            [sexButton setTitleColor:[UIColor mainColorBlue] forState:(UIControlStateNormal)];
            sexButton.layer.borderColor = [UIColor mainColorBlue].CGColor;
        }
    }
    //教育方式
    UILabel *teachWayLabel = [self sectionView:@"教育方式"];
    [_scrollView addSubview:teachWayLabel];
    teachWayLabel.frame = CGRectMake(15, teachsexLabel.bottom + 60, 120, 20);

    NSArray *ways = @[@"不限",@"视频录播",@"录音录播",@"视频直播",@"语音直播",@"线下面授"];
    for (int i = 0; i < 6; i++) {
        NSInteger H = i % 3;
        NSInteger V = i / 3;

        UIButton *sexButton = [self commonButton:ways[i]];
        [_scrollView addSubview:sexButton];
        sexButton.frame = CGRectMake(gap + H * (buttonW + 50), teachWayLabel.bottom +15 + V * (buttonH + 15), buttonW, buttonH);
        sexButton.tag = 200 + i;
        [sexButton addTarget:self action:@selector(teachWayButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        if (i == 5) {
            frameH = sexButton.bottom;
        }
        if (i == 0) {
            [sexButton setTitleColor:[UIColor mainColorBlue] forState:(UIControlStateNormal)];
            sexButton.layer.borderColor = [UIColor mainColorBlue].CGColor;
        }
    }
    
    //上课时间
    UILabel *timeLabel = [self sectionView:@"上课时间"];
    [_scrollView addSubview:timeLabel];
    timeLabel.frame = CGRectMake(15, frameH + 30, 120, 20);

    _timeView = [[ClassSearchClassTimeView alloc]init];
    _timeView.frame = CGRectMake(0, timeLabel.bottom + 15, ScreenWidth, 80);
    [_scrollView addSubview:_timeView];
    [self setTimeViewAction];
    
    //价格范围
    UILabel *priceLabel = [self sectionView:@"价格范围"];
    [_scrollView addSubview:priceLabel];
    priceLabel.frame = CGRectMake(15, _timeView.bottom + 30, 120, 20);
    
    _priceTextFiled = [self commonTextFiled:@"0"];
    [_scrollView addSubview:_priceTextFiled];
    _priceTextFiled.frame = CGRectMake(priceLabel.right + 10, priceLabel.top - 5, 50, 30);
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(_priceTextFiled.right + 10, _priceTextFiled.top + 15, 20, 1)];
    line.backgroundColor = [UIColor seperateThinLineColor];
    [_scrollView addSubview:line];
    
    _priceTextFiled1 = [self commonTextFiled:@"9999"];
    [_scrollView addSubview:_priceTextFiled1];
    _priceTextFiled1.frame = CGRectMake(line.right + 10, priceLabel.top - 5, 50, 30);
    //¥
    UILabel *pricePoint = [self sectionView:@"¥"];
    [_scrollView addSubview:pricePoint];
    pricePoint.textColor = [UIColor generalTitleFontGrayColor];
    pricePoint.frame = CGRectMake(ScreenWidth - 30 , _priceTextFiled1.top + 5, 15, 20);
    
    //上课地址是否由您指定
    _placeLabel = [self sectionView:@"上课地址是否由您指定"];
    [_scrollView addSubview:_placeLabel];
    _placeLabel.frame = CGRectMake(15, priceLabel.bottom + 30, 180, 20);


    _selectView = [[UISwitch alloc]initWithFrame:CGRectMake(ScreenWidth - 60, _placeLabel.top, 60, 30)];
    [_scrollView addSubview:_selectView];
    
    _selectView.tintColor = [UIColor whiteColor];
    _selectView.onTintColor = [UIColor mainColorBlue];
    [_selectView addTarget:self action:@selector(switchView:) forControlEvents:(UIControlEventTouchUpInside)];
    
    _placTextView = [[UITextView alloc]initWithFrame:CGRectMake(15, _selectView.bottom + 10, ScreenWidth - 30, 50)];
    [_scrollView addSubview:_placTextView];
    _placTextView.delegate = self;
    _placTextView.layer.cornerRadius = 5;
    _placTextView.layer.masksToBounds = YES;
    _placTextView.layer.borderWidth = 0.5;
    _placTextView.layer.borderColor = [UIColor seperateThinLineColor].CGColor;
    
    _placeLabel.hidden = YES;
    _placTextView.hidden = YES;
    _selectView.hidden = YES;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hiddenKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
    
}


#pragma mark Request Methods

- (void)requestData {
    
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.view endEditing:YES];

}

#pragma mark UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    _scrollView.frame = CGRectMake(0, -200, ScreenWidth, ScreenHeight);
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 35) {
        NSString *tmp = textView.text;
        textView.text = [tmp substringToIndex:35];
    }
}

#pragma mark - Privater Methods

- (void)hiddenKeyBoard:(NSNotification *)noti {
    _scrollView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
}

- (void)switchView:(UISwitch *)switchView {
    if (switchView.isOn) {
        _placTextView.hidden = NO;
    } else {
        _placTextView.hidden = YES;
    }
}


- (void)sexButtonClick:(UIButton *)button {
    
    [button setTitleColor:[UIColor mainColorBlue] forState:(UIControlStateNormal)];
    button.layer.borderColor = [UIColor mainColorBlue].CGColor;
    
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [self.view viewWithTag:100 + i];
        if (i != (button.tag - 100)){
            [btn setTitleColor:[UIColor generalTitleFontGrayColor] forState:(UIControlStateNormal)];
            btn.layer.borderColor = [UIColor seperateThinLineColor].CGColor;
        }
    }
}

- (void)teachWayButtonClick:(UIButton *)button {
    
    [button setTitleColor:[UIColor mainColorBlue] forState:(UIControlStateNormal)];
    button.layer.borderColor = [UIColor mainColorBlue].CGColor;
    
    for (int i = 0; i < 6; i++) {
        UIButton *btn = [self.view viewWithTag:200 + i];
        if (i != (button.tag - 200)){
            [btn setTitleColor:[UIColor generalTitleFontGrayColor] forState:(UIControlStateNormal)];
            btn.layer.borderColor = [UIColor seperateThinLineColor].CGColor;
            
            _placTextView.hidden = YES;
            _placeLabel.hidden = YES;
            _selectView.hidden = YES;
            
        } else {
            
            _placeLabel.hidden = NO;
            _selectView.hidden = NO;
        }
    }
}

- (void)setTimeViewAction {
    TSWeakSelf
    _timeView.startOrEndBlock = ^(NSInteger index) {
        TSDatePickerView *date = [[TSDatePickerView alloc]initWithDateAndTime:YES];
        [date showInView];
        date.TSDatePickerWithIntervalBlock = ^(NSString *date, NSTimeInterval timeInterval) {
            NSArray *dateStr = [date componentsSeparatedByString:@" "];
            if (index == 0) {
                weakSelf.startTime = timeInterval;
                [weakSelf.timeView setStartTime:dateStr];
                NSString *hourString = [weakSelf updateTimeForRow:timeInterval end:weakSelf.endTime];
                [weakSelf.timeView setHourTime:hourString];
            } else {
                weakSelf.endTime = timeInterval;
                [weakSelf.timeView  setEndTime:dateStr];
                NSString *hourString =  [weakSelf updateTimeForRow:weakSelf.startTime end:timeInterval];
                [weakSelf.timeView setHourTime:hourString];
            }
        };
    };
    
}

/** 通过行数, 返回更新时间 */
- (NSString *)updateTimeForRow:(NSTimeInterval)start end:(NSTimeInterval)end {
    if (start == 0 || end == 0) {
        return @"";
    }
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    NSTimeInterval currentTime = end;//[[NSDate date] timeIntervalSince1970];
    // 创建歌曲时间戳(后台返回的时间 一般是13位数字)
    NSTimeInterval createTime = start;//self.model.tracks.list[row].createdAt/1000;
    // 时间差
    NSTimeInterval time = currentTime - createTime;
    
    
    // 秒转分钟
    NSInteger minutes = time/60;
    if (minutes<60) {
        return [NSString stringWithFormat:@"%ld分钟",minutes];
    }
    
    // 秒转小时
    NSInteger hours = time/3600;
    if (hours<24) {
        return [NSString stringWithFormat:@"%ld小时",hours];
    }
    //秒转天数
    NSInteger days = time/3600/24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld天",days];
    }
    //秒转月
    NSInteger months = time/3600/24/30;
    if (months < 12) {
        return [NSString stringWithFormat:@"%ld月",months];
    }
    //秒转年
    NSInteger years = time/3600/24/30/12;
    return [NSString stringWithFormat:@"%ld年",years];
}

#pragma mark - Setter Getter Methods


- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _scrollView.showsVerticalScrollIndicator = YES;
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.contentSize = CGSizeMake(0, ScreenHeight);
    }
    return _scrollView;
}

- (UILabel *)sectionView:(NSString *)title {
    UILabel *section = [[UILabel alloc]init];
    section.textColor = [UIColor generalTitleFontBlackColor];
    section.font = [UIFont systemFontOfSize:15];
    section.text = title;
    return section;
}

- (TSCustomTextFiled *)commonTextFiled:(NSString *)title {
    TSCustomTextFiled *section = [[TSCustomTextFiled alloc]init];
    section.textColor = [UIColor generalTitleFontBlackColor];
    section.font = [UIFont systemFontOfSize:15];
    section.keyboardType = UIKeyboardTypeNumberPad;
    section.text = title;
    section.textAlignment = NSTextAlignmentCenter;
    section.MaxNum = 4;
    
    section.layer.cornerRadius = 5;
    section.layer.masksToBounds = YES;
    section.layer.borderColor = [UIColor seperateThinLineColor].CGColor;
    section.layer.borderWidth = 0.5;
    
    return section;
}


- (UIButton *)commonButton:(NSString *)title {
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:title forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor generalTitleFontGrayColor] forState:(UIControlStateNormal)];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = [UIColor seperateThinLineColor].CGColor;
    
    return button;
}

@end
