// UIImage+TSShape.h
// Created by Trevor Harmon on 9/20/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.

// Extends the UIImage class to support making rounded corners

#import <UIKit/UIKit.h>

@interface UIImage (TSShape)

#pragma mark - 图片压缩
// 将图片压缩成JPEG的格式，最大边大小为width。提交图片到网络用JPEG的格式会压缩很多数据量...
// 由于返回的是UIImage,此方法可能没多大用处
- (UIImage *)TS_imageByScalingWidth:(float)width;


/**
 等比压缩图片到指定大小

 @param targetSize 目标size
 @return UIImage
 */
- (UIImage *)TS_imageByScalingAndCroppingForSize:(CGSize)targetSize;

/**
 压缩图片到指定大小

 @param rect 目标rect
 @return UIImage
 */
- (UIImage *)TS_croppedWithrect:(CGRect)rect;


@end
