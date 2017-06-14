//
//  PhotoLibraryCollectionViewCell.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/13.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "PhotoLibraryCollectionViewCell.h"

@implementation PhotoLibraryCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.contentView sendSubviewToBack:_photoImageView];
    
}
- (IBAction)buttonClick:(id)sender {
    
    self.deletePhotoBlock();
}

@end
