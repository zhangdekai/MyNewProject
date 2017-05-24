//
//  SharerScendCollectionViewCell.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/22.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SharerScendCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *uplabel;

@property (weak, nonatomic) IBOutlet UILabel *downLabel;


- (void)setModel:(NSString *)title;

@end
