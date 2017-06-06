//
//  TSCustomTextFiled.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/19.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 CustomTextFiled 可设置最大字数，监听编辑状态（开始0 结束1）
 */

@interface TSCustomTextFiled : UITextField

@property (nonatomic,assign) NSInteger MaxNum;

@property (nonatomic,copy) void (^EditingStatasBlcok)(NSInteger index);


@end
