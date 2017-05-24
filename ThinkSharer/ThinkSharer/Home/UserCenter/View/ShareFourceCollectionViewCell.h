//
//  ShareFourceCollectionViewCell.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/23.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareFourceCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftIcon;


- (void)setModel:(NSString *)title iocn:(NSString *)iconName;


@end
