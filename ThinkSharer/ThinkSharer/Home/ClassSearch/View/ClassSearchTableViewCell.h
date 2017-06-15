//
//  ClassSearchTableViewCell.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/15.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassSearchModel.h"

@interface ClassSearchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;
@property (weak, nonatomic) IBOutlet UIButton *reserveButton;
@property (nonatomic,copy) void (^butonClickBlock)();
- (void)setCellModel:(ClassSearchModel *)model;

@end
