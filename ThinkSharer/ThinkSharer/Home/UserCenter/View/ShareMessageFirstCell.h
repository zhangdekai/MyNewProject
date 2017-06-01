//
//  ShareMessageFirstCell.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/1.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareMessageFirstCell : UITableViewCell

@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,assign) NSInteger number;
@property (nonatomic,copy) void(^reloadHeight)();


@end
