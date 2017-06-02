//
//  ShareMessageFourthCell.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/2.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareMessageFourthCell : UITableViewCell

@property (nonatomic,strong)  UILabel *leftLabel;
@property (nonatomic,strong)  UIButton *rightButton;

- (void)setRightButtonString:(NSString *)title;

@end
