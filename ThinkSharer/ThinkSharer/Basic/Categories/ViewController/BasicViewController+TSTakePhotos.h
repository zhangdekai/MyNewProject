//
//  BasicViewController+TSTakePhotos.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/5.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BasicViewController (TSTakePhotos)

/**
 选择相册，照片
 */
- (void)selectPhoto;


/**
 从相册获得照片

 @param photos 照片们
 */
- (void)selectedPhoto:(NSArray *)photos;


/**
 拍照

 @param photo 照片
 */
- (void)takedPhoto:(UIImage *)photo;


@end
