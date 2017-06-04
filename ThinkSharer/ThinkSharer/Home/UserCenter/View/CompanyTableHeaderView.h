//
//  CompanyTableHeaderView.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/4.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyTableHeaderView : UIView

@property (nonatomic,strong)UIImageView *headerImageView;
@property (nonatomic,copy) void (^SelectPhotoBlock)();


@end
