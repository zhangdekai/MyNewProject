//
//  ClassSearchTableViewCell.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/15.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "ClassSearchTableViewCell.h"

@implementation ClassSearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    
    _reserveButton.layer.cornerRadius = 5;
    [_reserveButton addTarget:self action:@selector(buttonClick)
             forControlEvents:(UIControlEventTouchUpInside)];
    
}

- (void)buttonClick {
    if (self.butonClickBlock) {
        self.butonClickBlock();
    }
}

- (void)setCellModel:(ClassSearchModel *)model {
    
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.lineSpacing = 8;
    
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:model.uplabelString];
    [attributeStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, model.uplabelString.length)];
    _introduceLabel.attributedText = attributeStr;
    
    [_reserveButton setTitle:model.buttonString forState:(UIControlStateNormal)];
    [_reserveButton setBackgroundColor:model.buttonColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
