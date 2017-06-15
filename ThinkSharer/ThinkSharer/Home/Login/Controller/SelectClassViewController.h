//
//  SelectClassViewController.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/17.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "BasicViewController.h"

@interface SelectClassViewController : BasicViewController

@property (nonatomic,assign) BOOL backSearchClass;
@property (nonatomic,copy) void (^backSearchClassWithKey)(NSString *keyWord);

@end
