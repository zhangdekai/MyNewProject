//
//  YMHIdenCodeTool.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/16.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMHIdenCodeTool : NSObject

/**
 *  生成单例对象
 *
 *  @return 单例
 */
+ (instancetype)sharedInstance;

+ (void)idenCodeActionWithButton:(UIButton *)sender controller:(UIViewController *)vc phoneNum:(NSString *)phoneNum;


@end
