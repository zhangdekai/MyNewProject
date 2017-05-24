//
//  SharerThirdCollectionViewCell.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/22.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "SharerThirdCollectionViewCell.h"

@implementation SharerThirdCollectionViewCell

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

}
- (void)setModel:(NSString *)title {
    _downIcon.image = [UIImage imageNamed:title];
}

@end
