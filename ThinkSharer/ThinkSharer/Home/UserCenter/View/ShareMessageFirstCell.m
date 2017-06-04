//
//  ShareMessageFirstCell.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/1.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "ShareMessageFirstCell.h"

@interface ShareMessageFirstCell ()<UITextViewDelegate>

@end

@implementation ShareMessageFirstCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        _textView = [[UITextView alloc]initWithFrame:CGRectMake(25, 10, ScreenWidth - 50, 85)];
        [self.contentView addSubview:_textView];
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.layer.cornerRadius = 5;
        _textView.layer.borderWidth = 0.5;
        _textView.layer.borderColor = [UIColor seperateThinLineColor].CGColor;
        
        
        _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth - 60, 80, 25, 15)];
        [self.contentView addSubview:_numLabel];
        _numLabel.font = [UIFont systemFontOfSize:14];
        _numLabel.textColor = [UIColor generalTitleFontGrayColor];
        _numLabel.textAlignment = NSTextAlignmentRight;
        _numLabel.text = @"100";
        
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
