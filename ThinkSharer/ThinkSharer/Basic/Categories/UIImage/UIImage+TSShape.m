// UIImage+TSShape.m
// Created by Trevor Harmon on 9/20/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.

#import "UIImage+TSShape.h"
#import "UIImage+TSAlpha.h"

@implementation UIImage (TSShape)

#pragma mark - 圆角带边框图片
// Creates a copy of this image with rounded corners
// If borderSize is non-zero, a transparent border of the given size will also be added
// Original author: Björn Sållarp. Used with permission. See: http://blog.sallarp.com/iphone-uiimage-round-corners/
- (UIImage *) TS_roundedCornerImage:(NSInteger) cornerSize borderSize:(NSInteger) borderSize
{
    // If the image does not have an alpha layer, add one
    UIImage *image = [self TS_imageWithAlpha];
    
    // Build a context that's the same dimensions as the new size
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 image.size.width,
                                                 image.size.height,
                                                 CGImageGetBitsPerComponent(image.CGImage),
                                                 0,
                                                 CGImageGetColorSpace(image.CGImage),
                                                 CGImageGetBitmapInfo(image.CGImage));
    
    // Create a clipping path with rounded corners
    CGContextBeginPath(context);
    [self TS_addRoundedRectToPath:CGRectMake(borderSize, borderSize, image.size.width - borderSize * 2, image.size.height - borderSize * 2)
                           context:context
                         ovalWidth:cornerSize
                        ovalHeight:cornerSize];
    CGContextClosePath(context);
    CGContextClip(context);
    
    // Draw the image to the context; the clipping path will make anything outside the rounded rect transparent
    CGContextDrawImage(context, CGRectMake(0, 0, image.size.width, image.size.height), image.CGImage);
    
    // Create a CGImage from the context
    CGImageRef clippedImage = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    // Create a UIImage from the CGImage
    UIImage *roundedImage = [UIImage imageWithCGImage:clippedImage];
    CGImageRelease(clippedImage);
    
    return roundedImage;
}

+ (UIImage *)TS_roundedImageWithImage:(UIImage *)originImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    // 1.加载原图
    UIImage *oldImage = originImage;
    
    // 2.开启上下文
    CGFloat contextWidth = oldImage.size.width + 2 * borderWidth;
    CGFloat contextHeight = oldImage.size.height + 2 * borderWidth;
    CGSize contextSize = CGSizeMake(contextWidth, contextHeight);
    UIGraphicsBeginImageContextWithOptions(contextSize, NO, 0.0);
    
    // 3.取得当前的上下文,这里得到的就是上面刚创建的那个图片上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = contextWidth * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆。As a side effect when you call this function, Quartz clears the current path.
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)TS_ellipseImageWithImage:(UIImage *)originImage
{
    // 圆形图像距离图像的边距
    CGFloat padding = 0;
    // 图像的背景色
    UIColor *epsBackColor = [UIColor clearColor];
    
    CGSize originsize = originImage.size;
    
    CGRect originRect = CGRectMake (0, 0, originsize.width, originsize.height);
    
    UIGraphicsBeginImageContext(originsize);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 目标区域
    CGRect desRect =  CGRectMake(padding, padding,originsize. width - (padding * 2), originsize. height - (padding * 2));
    
    // 设置填充背景色
    CGContextSetFillColorWithColor(ctx, epsBackColor.CGColor);
    // 真正的填充
    UIRectFill(originRect);
    
    // 设置椭圆变形区域
    CGContextAddEllipseInRect(ctx,desRect);
    // 截取椭圆区域
    CGContextClip (ctx);
    // 将图像画在目标区域
    [originImage drawInRect:originRect];
    
    UIImage * desImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return desImage;
    
}

#pragma mark -
#pragma mark Private helper methods

// Adds a rectangular path to the given context and rounds its corners by the given extents
// Original author: Björn Sållarp. Used with permission. See: http://blog.sallarp.com/iphone-uiimage-round-corners/
- (void) TS_addRoundedRectToPath:(CGRect) rect context:(CGContextRef) context ovalWidth:(CGFloat) ovalWidth ovalHeight:(CGFloat) ovalHeight
{
    if (ovalWidth == 0 || ovalHeight == 0)
    {
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    CGFloat fw = CGRectGetWidth(rect) / ovalWidth;
    CGFloat fh = CGRectGetHeight(rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}


#pragma mark - 可拉伸图片
- (UIImage *)TS_resizableImage
{
    CGSize imageSize = self.size;
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(imageSize.height / 2, imageSize.width / 2, imageSize.height / 2, imageSize.width / 2)];
}

- (UIImage *)TS_resizeImageWithQuality:(CGInterpolationQuality)quality rate:(CGFloat)rate
{
    UIImage *resized = nil;
    CGFloat width = self.size.width * rate;
    CGFloat height = self.size.height * rate;
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, quality);
    [self drawInRect:CGRectMake(0, 0, width, height)];
    resized = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resized;
}

#pragma mark - 单色图片
+ (UIImage *)TS_imageWithColor:(UIColor *)color
{
    return [UIImage TS_imageWithColor:color size:CGSizeMake(16, 16)];
}

+ (UIImage *)TS_imageWithColor:(UIColor *)color size:(CGSize)size
{
    return [UIImage TS_imageWithColor:color opaque:1 size:size];
    //    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    //    UIGraphicsBeginImageContext(rect.size);
    //    CGContextRef context = UIGraphicsGetCurrentContext();
    //    CGContextSetFillColorWithColor(context,color.CGColor);
    //    CGContextFillRect(context, rect);
    //    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    //    return img;
}

+ (UIImage *)TS_imageWithColor:(UIColor *)color opaque:(BOOL)opaque size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, opaque, 0);
    [color set];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)];
    [path fill];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)TS_roundedImageWithColor:(UIColor *)color opaque:(BOOL)opaque size:(CGSize)size cornerRadius:(CGFloat)cornerRadius {
    UIGraphicsBeginImageContextWithOptions(size, opaque, 0);
    [color set];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:cornerRadius];
    [path fill];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)TS_imageWithColor:(UIColor *)color opaque:(BOOL)opaque size:(CGSize)size shape:(UIBezierPath *)shape {
    UIGraphicsBeginImageContextWithOptions(size, opaque, 0);
    [color set];
    [shape fill];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

#pragma mark - 图片压缩
- (UIImage*)TS_imageByScalingWidth:(float)width
{
    CGSize size = self.size;
    float scale = 1.0f;
    if (size.width >= size.height)
    {
        scale = width / size.width;
    }
    else
    {
        scale = width / size.height;
    }
    if ( scale < 0.3f)
    {
        scale = 0.3f;
    }
    NSData *imageData = UIImageJPEGRepresentation(self,scale);
    
    return [UIImage imageWithData:imageData];
}

- (UIImage*)TS_imageByScalingAndCroppingForSize:(CGSize)targetSize{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
}


- (UIImage *)TS_croppedWithrect:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, rect, subImageRef);
    UIImage *viewImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    CGImageRelease(subImageRef);
    return viewImage;
}


@end
