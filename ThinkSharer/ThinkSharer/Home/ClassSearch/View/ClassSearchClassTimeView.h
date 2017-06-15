//
//  ClassSearchClassTimeView.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/15.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassSearchClassTimeView : UIView

@property (nonatomic,copy) void (^startOrEndBlock)(NSInteger index);

- (void)setStartTime:(NSArray *)timeArray;

- (void)setEndTime:(NSArray *)timeArray;

- (void)setHourTime:(NSString *)hour;

@end
