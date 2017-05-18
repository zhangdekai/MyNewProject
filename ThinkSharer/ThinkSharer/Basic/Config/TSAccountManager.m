//
//  TSAccountManager.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/16.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "TSAccountManager.h"

@implementation TSAccountManager

#pragma mark - single instance
+ (TSAccountManager *)shareInstance
{
    static dispatch_once_t onceToken;
    static TSAccountManager *_instance = nil;
    
    dispatch_once(&onceToken, ^{
        _instance = [[TSAccountManager alloc] init];
    });
    
    return _instance;
}




@end
