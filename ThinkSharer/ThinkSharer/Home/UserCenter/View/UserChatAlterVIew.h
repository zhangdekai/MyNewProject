//
//  UserChatAlterVIew.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/9.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ChatCommentType) {
    ChatCommentTypeGood,
    ChatCommentTypeNotGood,
    ChatCommentTypeBad,
};

@interface UserChatAlterVIew : UIView

@property (nonatomic,copy) void (^ChatCommentBlock) (ChatCommentType type);

@end
