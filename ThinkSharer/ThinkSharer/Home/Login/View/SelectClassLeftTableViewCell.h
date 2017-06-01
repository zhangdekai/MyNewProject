//
//  SelectClassLeftTableViewCell.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/31.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectClassLeftTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *leftLabel;

- (void)setLeftModel:(NSString *)text;

@end
