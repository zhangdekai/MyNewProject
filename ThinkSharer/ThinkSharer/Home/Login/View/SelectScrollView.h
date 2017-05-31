//
//  SelectScrollView.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/17.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectClassBlock)(NSString *title);

@interface SelectScrollView : UIScrollView

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong) UIView *blueLine;

@property (nonatomic,copy) SelectClassBlock selectItem;


- (instancetype)initWithFrame:(CGRect)frame selectItems:(NSMutableArray *)items ;

@end
