 //
//  UIImageView+YMHPlaceholder.h
//  CoreFrame
//
//  Created by 张德凯 on 2017/5/19.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (YMHPlaceholder)

- (void)TSLoadImageWithTFSKey:(NSString *)tfsKey;

- (void)TSLoadAvertWithTFSKey:(NSString *)tfsKey;

- (void)TSLoadAvatarWithTFSKey:(NSString *)tfsKey;

- (void)TSLoadImageAspectFillWithTFSKey:(NSString *)tfsKey;

- (void)TSLoadImageWithTFSKey:(NSString *)tfsKey contentMode :(UIViewContentMode)contentMode;

- (void)TSLoadImageWithTFSKey:(NSString *)tfsKey contentMode :(UIViewContentMode)contentMode imageWidth :(NSInteger)width imageHeight :(NSInteger)height;

- (void)TSLoadImageWithTFSKey:(NSString *)tfsKey placeHolderImage :(UIImage *)image contentMode :(UIViewContentMode)contentMode imageWidth :(NSInteger)width imageHeight :(NSInteger)height;

@end
