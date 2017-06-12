//
//  TSAlterShowView.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/6.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 展示 container View
 */
@interface TSAlterShowView : UIView

/**
 创建view container

 @param container 容器
 */
- (void)creatContainerView:(UIView *)container;


/**
 展示view
 */
- (void)showView;

/**
 收起view
 */
- (void)hiddenAlter;

@end
