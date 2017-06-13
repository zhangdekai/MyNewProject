//
//  ShareFourceCollectionViewCell.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/23.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "ShareFourceCollectionViewCell.h"

@implementation ShareFourceCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self layoutIfNeeded];
    
    self.contentView.backgroundColor = [UIColor backgroundGrayColorA];
    
    
    _containerView.layer.cornerRadius = 5;
    //    _containerView.layer.borderWidth = 0.1;
    
    [[_containerView layer]setShadowOffset:(CGSizeMake(0, 2))];
    [[_containerView layer]setShadowRadius:2];
    [[_containerView layer]setShadowOpacity:0.3];
    [[_containerView layer]setShadowColor:[UIColor viewShaowColor].CGColor];
    
    if (isPad) {
        _leftConstance.constant = (ScreenWidth - 30) / 2 -50 ;
    }
    
}

- (void)setModel:(NSString *)title iocn:(NSString *)iconName {
    
    _leftIcon.image = [UIImage imageNamed:iconName];
    
    _rightLabel.text = title;
    
}


@end
