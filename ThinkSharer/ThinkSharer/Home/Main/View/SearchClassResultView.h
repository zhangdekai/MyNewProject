//
//  SearchClassResultView.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/15.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchClassResultView : UIView


/**
 首页展示提示操作View
 */
@property (nonatomic,copy) void(^searchClassResult)();

- (void)creatActionAlterView:(NSString *)titleString action:(void(^)())block;

- (void)showInView;

- (void)hiddenAlter;


@end
