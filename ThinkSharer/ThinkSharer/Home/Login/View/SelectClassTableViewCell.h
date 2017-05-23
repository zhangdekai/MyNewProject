//
//  SelectClassTableViewCell.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/17.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectClassBlock)(NSString *title);

@interface SelectClassTableViewCell : UITableViewCell

@property (nonatomic,copy) SelectClassBlock selectBlock;

- (void)setLabelModel:(NSMutableArray *)titles;

@end
