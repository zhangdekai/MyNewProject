//
//  SelectClassTableViewCell.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/17.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "SelectClassTableViewCell.h"

@implementation SelectClassTableViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        CGFloat labelWidth = (ScreenWidth - 30) / 3;
        CGFloat labelHeight = [TSPublicTool getRealPX:44];
        
        for (int i = 0; i < 3; i++) {
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15 + labelWidth * i, 0, labelWidth, labelHeight)];
            [self.contentView addSubview:label];
            
            label.textColor = [UIColor generalTitleFontGrayColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:17];
            label.tag = 100 + i;
            
        }
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, labelHeight - 0.5, ScreenWidth, 0.5)];
        [self.contentView addSubview:line];
        line.backgroundColor = [UIColor seperateThinLineColor];
        
    }
    return self;
}

- (void)setLabelModel:(NSMutableArray *)titles {
    
    for (int i = 0; i < 3; i++) {
        UILabel *label = (UILabel *)[self.contentView viewWithTag: i + 100];
        if (i < titles.count) {
            label.text = titles[i];

        } else {
            label.hidden = YES;
        }
        
    }
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
