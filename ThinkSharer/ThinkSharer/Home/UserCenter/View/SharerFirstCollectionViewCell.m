//
//  SharerFirstCollectionViewCell.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/19.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "SharerFirstCollectionViewCell.h"

@implementation SharerFirstCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.companyScrollView.contentSize = CGSizeMake(ScreenHeight * 2, 0);
    // Initialization code
    
    CGRect frame = _backView.frame;
    frame.size.width = ScreenWidth;
    _backView.frame = frame;
    
    [_backView addShadowWithoutCorner];
    [self.contentView sendSubviewToBack:_backView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMethod:)];
    [_headerImageView addGestureRecognizer:tap];
}


- (void)tapMethod:(UITapGestureRecognizer *)tap {
    
    self.headerImageBlock();
}


@end
