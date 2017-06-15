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

@property (nonatomic,copy) SelectClassBlock selectItem;


/**
 SelectScrollView

 @param frame frame
 @param items itemArray
 @return SelectScrollView
 */
- (instancetype)initWithFrame:(CGRect)frame selectItems:(NSMutableArray *)items ;


/**
 SelectScrollView

 @param frame frame
 @param items itemArray string
 @param maxNum 每行显示几个
 @return SelectScrollView
 */
- (instancetype)initWithFrame:(CGRect)frame selectItems:(NSMutableArray *)items maxNumInAline:(NSInteger)maxNum;
@end
