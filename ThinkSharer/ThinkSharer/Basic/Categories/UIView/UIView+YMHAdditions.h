//
//  UIView+YMHAdditions.h
//  CoreFrame
//
//  Created by wangguangfeng on 15/10/18.
//  Copyright © 2015年 Beijing Yimay Holiday Information Science & Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YMHAdditions)

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

@property (nonatomic, retain) UIColor *borderColor;

@property (nonatomic, readonly) UIViewController *viewController;

- (void)centerInSuperView;
- (void)aestheticCenterInSuperView;

- (UIImage *)imageForView;

@end
