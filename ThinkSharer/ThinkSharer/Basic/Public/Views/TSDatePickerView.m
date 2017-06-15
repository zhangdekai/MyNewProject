//
//  TSDatePickerView.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/31.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "TSDatePickerView.h"

@interface TSDatePickerView ()

@property (nonatomic,strong) UIView *backHUD;
@property (nonatomic,strong) UIView *birthdayContainer;

@property (nonatomic,strong) UIDatePicker *birthdayPickerView;
@property (nonatomic,strong) UIToolbar *birthdayToolBar;

@property (nonatomic,assign) BOOL dateAndTime;

@end

@implementation TSDatePickerView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor = [UIColor clearColor];
        
        _backHUD = [[UIView alloc]initWithFrame:self.bounds];
        _backHUD.backgroundColor = [UIColor blackColor];
        _backHUD.alpha = 0.3;
        [self addSubview:_backHUD];
        
        [self creatActionAlterView:NO];
    }
    return self;
}

- (instancetype)initWithDateAndTime:(BOOL)dateAndTime {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor = [UIColor clearColor];
        _dateAndTime = dateAndTime;
        _backHUD = [[UIView alloc]initWithFrame:self.bounds];
        _backHUD.backgroundColor = [UIColor blackColor];
        _backHUD.alpha = 0.3;
        [self addSubview:_backHUD];
        [self creatActionAlterView:dateAndTime];
    }
    return self;
}




- (void)creatActionAlterView:(BOOL)dateAndTime {
    
    _birthdayContainer = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 255)];
    _birthdayContainer.backgroundColor = [UIColor whiteColor];
    [self addSubview:_birthdayContainer];
    
    
    
    _birthdayToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    [_birthdayContainer addSubview:_birthdayToolBar];
    _birthdayToolBar.barTintColor = [UIColor whiteColor];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(toolBarCancleButtonClicked)];
    leftItem.tintColor = [UIColor mainColorBlue];
    UIBarButtonItem *centerSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(birthdayToolBarDoneButtonClicked)];
    rightItem.tintColor = [UIColor mainColorBlue];
    _birthdayToolBar.items=@[leftItem, centerSpace, rightItem];

    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, _birthdayToolBar.bottom, ScreenWidth, 0.5)];
    line.backgroundColor = [UIColor mainColorBlue];
    [_birthdayContainer addSubview:line];
    
    
    _birthdayPickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, line.bottom, ScreenWidth, 200)];
    _birthdayPickerView.backgroundColor = [UIColor whiteColor];
    if (dateAndTime) {
        _birthdayPickerView.datePickerMode = UIDatePickerModeDateAndTime;
    } else {
        _birthdayPickerView.datePickerMode = UIDatePickerModeDate;
    }
    [_birthdayContainer addSubview:_birthdayPickerView];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [calendar setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    if (dateAndTime) {
        [comps setYear:50];
    } else {
        [comps setYear:0];
    }
    [comps setMonth:0];
    [comps setDay:0];
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    if (dateAndTime) {
        [comps setYear:0];
    } else {
        [comps setYear:-120];
    }
    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    _birthdayPickerView.maximumDate = maxDate;
    _birthdayPickerView.minimumDate = minDate;
    _birthdayPickerView.calendar = calendar;
    

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [_backHUD addGestureRecognizer:tap];
    
    
}

- (void)showInView {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _birthdayContainer.frame = CGRectMake(0, ScreenHeight - 245, ScreenWidth, 245);
        
        
    } completion:nil];
    
}

//取消
- (void)toolBarCancleButtonClicked {
    
    [UIView animateWithDuration:0.3 animations:^{
        _birthdayContainer.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 245);

    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
 
}


//确定
- (void)birthdayToolBarDoneButtonClicked {
    [self toolBarCancleButtonClicked];
    
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:_birthdayPickerView.date];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:_birthdayPickerView.date];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate *destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:_birthdayPickerView.date];
    
    NSString *birthday = [[NSString stringWithFormat:@"%@",destinationDateNow] substringToIndex:10];
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    if (_dateAndTime) {
        [dateformatter setDateFormat:@"yyyy-MM-dd EEE HH:mm"];
        NSString *currentDateStr = [dateformatter stringFromDate:_birthdayPickerView.date];
        NSLog(@"%@",currentDateStr);
        self.TSDatePickerWithIntervalBlock(currentDateStr, [_birthdayPickerView.date timeIntervalSinceReferenceDate]);
//        self.TSDatePickerBlock(currentDateStr);
        return;
    } else {
        [dateformatter setDateFormat:@"yyyy-MM-dd"];
    }
    NSLog(@"%@",birthday);
    
    self.TSDatePickerBlock(birthday);
    
}



- (void)hiddenAlter {
    [self toolBarCancleButtonClicked];

}

- (void)tapAction:(UITapGestureRecognizer*)tap {
    [self hiddenAlter];
   
}

- (void)tapAction1:(UITapGestureRecognizer*)tap {
    [self hiddenAlter];
}


@end
