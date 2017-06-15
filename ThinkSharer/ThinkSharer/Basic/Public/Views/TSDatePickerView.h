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


@property (nonatomic,copy) void (^TSDatePickerBlock)(NSString *date);

@property (nonatomic,copy) void (^TSDatePickerWithIntervalBlock)(NSString *date, NSTimeInterval timeInterval);

- (instancetype)initWithDateAndTime:(BOOL)dateAndTime;

- (void)showInView;


@end
