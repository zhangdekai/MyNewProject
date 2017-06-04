//
//  PersonalOrCompanyView.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/4.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalOrCompanyView : UIView

@property (nonatomic,strong) UIView *backHUD;

@property (nonatomic,copy) void(^SelectPersonOrCompany)(NSInteger index);


- (void)showInView;


@end
