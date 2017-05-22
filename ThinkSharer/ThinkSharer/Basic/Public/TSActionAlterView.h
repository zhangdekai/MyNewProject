//
//  TSActionAlterView.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/22.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>

//创建自定义提示alter

typedef void(^AlterBlock)();

@interface TSActionAlterView : UIView

@property (nonatomic,strong) UIView *backHUD;

@property (nonatomic,copy) AlterBlock actionBlock;

- (void)creatActionAlterView:(NSString *)imageName rect:(CGRect)rect action:(AlterBlock)block;

- (void)showInView;

- (void)hiddenAlter;

@end