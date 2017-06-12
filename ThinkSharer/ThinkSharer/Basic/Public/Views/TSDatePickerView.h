//
//  TSDatePickerView.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/31.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 时间选择器
 */
@interface TSDatePickerView : UIView

@property (nonatomic,strong) UIView *backHUD;
@property (nonatomic,strong) UIView *birthdayContainer;

@property (nonatomic,strong) UIDatePicker *birthdayPickerView;
@property (nonatomic,strong) UIToolbar *birthdayToolBar;

@property (nonatomic,copy) void (^TSDatePickerBlock)(NSString *date);

- (void)showInView;


@end
