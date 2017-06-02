//
//  ShareMessageSecondCell.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/2.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "ShareMessageSecondCell.h"

@implementation ShareMessageSecondCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(15, 25, 10, 15)];
        [self.contentView addSubview:icon];
        icon.image = [UIImage imageNamed:@"userMessage_location"];
        
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(icon.right + 10, 15, ScreenWidth - 80, 20)];
        [self.contentView addSubview:_addressLabel];
        _addressLabel.text = @"北京市昌平区西三旗桥北近旁元小区ssdfsdsdfsf";
        _addressLabel.textColor = [UIColor generalTitleFontGrayColor];
        _addressLabel.font = [UIFont systemFontOfSize:15];
//        _addressLabel.numberOfLines = 0;
//        [_addressLabel sizeToFit];
        
        UIView *grayLine = [[UIView alloc]init];//WithFrame:CGRectMake(0, _addressLabel.bottom + 15, ScreenWidth, 0.5)];
        [self.contentView addSubview:grayLine];
        grayLine.backgroundColor = [UIColor seperateThinLineColor];
        
        [grayLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth, 0.5));
            make.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)setAddressModel:(NSString *)address {
    _addressLabel.frame = CGRectMake(35, 15, ScreenWidth - 80, 20);
    _addressLabel.text = address;
    [_addressLabel setNumberOfLines:0];
    [_addressLabel setLineBreakMode:NSLineBreakByCharWrapping];
    [_addressLabel sizeToFit];
 
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
