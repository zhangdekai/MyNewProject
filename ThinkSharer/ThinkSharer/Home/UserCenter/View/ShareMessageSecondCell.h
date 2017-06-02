//
//  ShareMessageSecondCell.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/2.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareMessageSecondCell : UITableViewCell

@property (nonatomic,strong) UILabel *addressLabel;


- (void)setAddressModel:(NSString *)address;

@end
