//
//  CompanyFirstCell.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/4.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "CompanyFirstCell.h"

@implementation CompanyFirstCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //企业简称
        
        UILabel *nickName = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 90, 20)];
        [self.contentView addSubview:nickName];
        
        nickName.textColor = [UIColor generalTitleFontBlackColor];
        
        nickName.font = [UIFont systemFontOfSize:15];
        
        nickName.text = @"企业简称";
        
        
        
        _nickTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(nickName.right +15, nickName.top, ScreenWidth - nickName.right - 30, 30)];
        [self.contentView addSubview:_nickTextFiled];
        _nickTextFiled.font = [UIFont systemFontOfSize:13];
        _nickTextFiled.textColor = [UIColor generalTitleFontBlackColor];
        _nickTextFiled.textAlignment = NSTextAlignmentRight;
        _nickTextFiled.placeholder = @"八字以内";
        
        _nickLine = [[UIView alloc]initWithFrame:CGRectMake(0, nickName.bottom + 14.5, ScreenWidth, 0.5)];
        [self.contentView addSubview:_nickLine];
        _nickLine.backgroundColor = [UIColor seperateThinLineColor];

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
