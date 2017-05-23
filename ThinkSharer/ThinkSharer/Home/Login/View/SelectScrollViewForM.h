//
//  SelectScrollViewForM.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/22.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectScrollView.h"

@interface SelectScrollViewForM : UIScrollView

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic,copy) SelectClassBlock selectItem;


- (instancetype)initWithFrame:(CGRect)frame selectItems:(NSMutableArray *)items ;


- (void)setNewItems:(NSMutableArray *)items;

@end
