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
- (void)selectPhoto:(NSInteger)maxNum;

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


/**
 打开相册
 */
- (void)openPhoto;


/**
 打开相机
 */
- (void)openCamer;

/**
 放大图片

 @param photoImageViews UIImageView 数组
 @param index 点击图片的index
 */
- (void)browerPhotos:(NSArray<UIImageView *> *)photoImageViews touchIndex:(NSInteger)index;

- (void)browerPhotosByUIImage:(NSArray<UIImage *> *)photoImages touchIndex:(NSInteger)index;


@end
