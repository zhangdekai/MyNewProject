//
//  ShareMessageFourthCell.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/2.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "ShareMessageFourthCell.h"

@implementation ShareMessageFourthCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 10, 95, 20)];
        [self.contentView addSubview:_leftLabel];
        
        _leftLabel.textColor = [UIColor generalTitleFontBlackColor];
        
        _leftLabel.font = [UIFont systemFontOfSize:15];
        
        _leftLabel.text = @"工作单位：";
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 43.5, ScreenWidth, 0.5)];
        [self.contentView addSubview:line];
        line.backgroundColor = [UIColor seperateThinLineColor];
        
        
        _rightButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - 75, _leftLabel.top, 60, 20)];
        [self.contentView addSubview:_rightButton];
        [_rightButton setTitle:@"换联网+" forState:(UIControlStateNormal)];
        [_rightButton setTitleColor:[UIColor generalTitleFontGrayColor] forState:(UIControlStateNormal)];
        [_rightButton setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentRight)];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
        
        
    }
    return self;
}

- (void)setRightButtonString:(NSString *)title {
    if ([title isEqualToString:@"已认证"]) {
        [_rightButton setTitleColor:[UIColor generalTitleFontGrayColor] forState:(UIControlStateNormal)];
    } else if ([title isEqualToString:@"认证中"]) {
        [_rightButton setTitleColor:[UIColor mainColorBlue] forState:(UIControlStateNormal)];

    } else  if ([title isEqualToString:@"未认证"]) {
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_rightButton setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];

    } else {
        UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(_rightButton.size.width - 20, 0, 20, 20)];
        icon.image = [UIImage imageNamed:@"userMessage_add"];
    }
    [_rightButton setTitle:title forState:(UIControlStateNormal)];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
