//
//  CompanyScondCell.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/4.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "CompanyScondCell.h"

@implementation CompanyScondCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //企业简称
        
        _leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 90, 20)];
        [self.contentView addSubview:_leftLabel];
        
        _leftLabel.textColor = [UIColor generalTitleFontBlackColor];
        
        _leftLabel.font = [UIFont systemFontOfSize:15];
        
        _leftLabel.text = @"企业简称";
        
        
        
        _rightButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - 75, _leftLabel.top, 60, 20)];
        [self.contentView addSubview:_rightButton];
        [_rightButton setTitle:@"请选择" forState:(UIControlStateNormal)];
        [_rightButton setTitleColor:[UIColor generalTitleFontGrayColor] forState:(UIControlStateNormal)];
        [_rightButton setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentRight)];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
        
        UIView *grayLine = [[UIView alloc]initWithFrame:CGRectMake(0, _leftLabel.bottom + 14.5, ScreenWidth, 0.5)];
        [self addSubview:grayLine];
        grayLine.backgroundColor = [UIColor seperateThinLineColor];
        
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
