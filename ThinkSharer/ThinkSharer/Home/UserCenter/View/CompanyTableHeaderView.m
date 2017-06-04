//
//  CompanyTableHeaderView.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/4.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "CompanyTableHeaderView.h"

@implementation CompanyTableHeaderView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, 482);
        self.backgroundColor = [UIColor whiteColor];
        
        //头像
        _headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 310)];
        
        [self addSubview:_headerImageView];
        
        _headerImageView.userInteractionEnabled = YES;
        
        _headerImageView.image = [UIImage imageNamed:@"testHeader"];
        

        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, _headerImageView.bottom, ScreenWidth, 15)];
        [self addSubview:line];
        line.backgroundColor = [UIColor backgroundGrayColorA];
        
        
        
    }
    return self;
}

@end
