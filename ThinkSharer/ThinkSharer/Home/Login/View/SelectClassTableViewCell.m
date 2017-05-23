//
//  SelectClassTableViewCell.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/17.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "SelectClassTableViewCell.h"

@implementation SelectClassTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self) {
        CGFloat labelWidth = (ScreenWidth - 15) / 3;
        CGFloat labelHeight = [TSPublicTool getRealPX:50];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 15, 4, 15)];
        line.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:line];
        
        line.tag = 200;
        
        for (int i = 0; i < 3; i++) {
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15 + labelWidth * i, 0, labelWidth, labelHeight)];
            [self.contentView addSubview:label];
            label.textColor = [UIColor generalTitleFontGrayColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:17];
            label.tag = 100 + i;
            
            label.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMethod:)];
            [label addGestureRecognizer:tap];
            
        }
        
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, labelHeight - 0.5, ScreenWidth, 0.5)];
        [self.contentView addSubview:line1];
        line1.backgroundColor = [UIColor seperateThinLineColor];
    }
    return self;
}

- (void)tapMethod:(UITapGestureRecognizer *)tap {
    
    NSInteger tag = tap.view.tag;
    
    UILabel *label = (UILabel *)[self.contentView viewWithTag: tag];

    self.selectBlock(label.text);
    
    
    
}


- (void)setLabelModel:(NSMutableArray *)titles {
    UIView *line = [self.contentView viewWithTag: 200];
    line.backgroundColor = [UIColor orangeColor];

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
