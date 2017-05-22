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
}

@end
