//
//  ShareMessageThirdCell.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/2.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "ShareMessageThirdCell.h"

@implementation ShareMessageThirdCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        
       _leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 15, 90, 20)];
        [self.contentView addSubview:_leftLabel];
        
        _leftLabel.textColor = [UIColor generalTitleFontGrayColor];
        
        _leftLabel.font = [UIFont systemFontOfSize:15];
        
        _leftLabel.text = @"工作单位：";
        
        _downLine = [[UIView alloc]initWithFrame:CGRectMake(0, 49.5, ScreenWidth, 0.5)];
        [self.contentView addSubview:_downLine];
        _downLine.backgroundColor = [UIColor seperateThinLineColor];
        
        
        _rightTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(105, _leftLabel.top, ScreenWidth - 115, 20)];
        [self.contentView addSubview:_rightTextFiled];
        _rightTextFiled.font = [UIFont systemFontOfSize:15];
        _rightTextFiled.textColor = [UIColor generalTitleFontGrayColor];
        _rightTextFiled.textAlignment = NSTextAlignmentRight;
        _rightTextFiled.placeholder = @"点击完善";
        

    }
    return self;
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
