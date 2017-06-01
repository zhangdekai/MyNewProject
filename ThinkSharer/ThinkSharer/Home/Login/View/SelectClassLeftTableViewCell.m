//
//  SelectClassLeftTableViewCell.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/31.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "SelectClassLeftTableViewCell.h"

@implementation SelectClassLeftTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.backgroundColor = [UIColor backgroundGrayColorA];
        _leftLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_leftLabel];
        [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        _leftLabel.textColor = [UIColor generalTitleFontBlackColor];
        _leftLabel.font = [UIFont systemFontOfSize:15];
        
        //设置UITableViewCell的选中背景颜色的方法
        UIView *view = [[UIView alloc]init];
        view.backgroundColor=[UIColor whiteColor];
        self.selectedBackgroundView=view;
    }
    
    return self;
}

- (void)setLeftModel:(NSString *)text {
    _leftLabel.text = text;
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
