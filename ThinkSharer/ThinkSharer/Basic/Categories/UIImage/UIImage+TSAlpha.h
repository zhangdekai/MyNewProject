// UIImage+TSAlpha.h
// Created by Trevor Harmon on 9/20/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.

// Helper methods for adding an alpha layer to an image

#import <UIKit/UIKit.h>

@interface UIImage (TSAlpha)

/**
 *  判断一个图片是否有alpha通道
 *
 *  @return YES or NO
 */
- (BOOL) TS_hasAlpha;
/**
 *  为图片增加一个alpha通道
 *
 *  @return 一个新图片
 */
- (UIImage *) TS_imageWithAlpha;
/**
 *  为图片生成一个透明边框
 *
 *  @param borderSize 边框的宽度
 *
 *  @return 包含透明边框的新图片
 */
- (UIImage *) TS_transparentBorderImage:(NSUInteger) borderSize;
- (CGImageRef) TS_newBorderMask:(NSUInteger) borderSize size:(CGSize) size;

@end
