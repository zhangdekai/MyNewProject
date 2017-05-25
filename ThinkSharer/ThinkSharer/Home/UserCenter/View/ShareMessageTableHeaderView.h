//
//  ShareMessageTableHeaderView.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/24.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareMessageTableHeaderView : UIView

@property (nonatomic,strong) UIImageView *headerImageView;
@property (nonatomic,strong) UIImageView *camerIcon;
@property (nonatomic,strong) UITextField *nickTextFiled;
@property (nonatomic,strong) UIView *nickLine;
@property (nonatomic,strong) UIButton *birthdayButton;


@property (nonatomic,copy) void (^SelectPhotoBlock)();
@property (nonatomic,copy) void (^SelectBirthdatBlock)();


- (void)setBirthdayString:(NSString *)birthday;

@end
