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
        
        _leftLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_leftLabel];
        [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            
        }];
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
