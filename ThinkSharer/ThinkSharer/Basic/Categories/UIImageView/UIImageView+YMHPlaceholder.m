//
//  UIImageView+YMHPlaceholder.m
//  CoreFrame
//
//  Created by 张德凯 on 2017/5/19.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "UIImageView+YMHPlaceholder.h"

@implementation UIImageView (YMHPlaceholder)

- (void)TSLoadImageWithTFSKey:(NSString *)tfsKey
{
    [self TSLoadImageWithTFSKey:tfsKey contentMode:UIViewContentModeScaleToFill];
}

- (void)TSLoadImageAspectFillWithTFSKey:(NSString *)tfsKey
{
    [self TSLoadImageWithTFSKey:tfsKey contentMode:UIViewContentModeScaleAspectFill];
}

- (void)TSLoadImageWithTFSKey:(NSString *)tfsKey  contentMode :(UIViewContentMode)contentMode
{
    self.contentMode = contentMode;
    [self sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TSAPI_TFSUrl,tfsKey]] placeholderImage:[UIImage imageNamed:@"logo_gray"] completed:NULL];
}

- (void)TSLoadAvatarWithTFSKey:(NSString *)tfsKey
{
    [self TSLoadAvatarWithTFSKey:tfsKey contentMode:UIViewContentModeScaleToFill];
}

- (void)TSLoadAvatarWithTFSKey:(NSString *)tfsKey  contentMode:(UIViewContentMode)contentMode
{
    self.contentMode = contentMode;
    [self sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TSAPI_TFSUrl,tfsKey]] placeholderImage:[UIImage imageNamed:@"user_center_default_avatar"] completed:NULL];
}

- (void)TSLoadImageWithTFSKey:(NSString *)tfsKey contentMode :(UIViewContentMode)contentMode imageWidth :(NSInteger)width imageHeight :(NSInteger)height
{
    [self TSLoadImageWithTFSKey:tfsKey placeHolderImage:[UIImage imageNamed:@"logo_gray"] contentMode:contentMode imageWidth:width imageHeight:height];
}

- (void)TSLoadImageWithTFSKey:(NSString *)tfsKey placeHolderImage:(UIImage *)placeHolderImage contentMode:(UIViewContentMode)contentMode imageWidth:(NSInteger)width imageHeight:(NSInteger)height
{
    self.contentMode = contentMode;
    NSArray *stringArray = [tfsKey componentsSeparatedByString:@"."];
    NSString *realTFSKey = stringArray.firstObject;
    NSString *string = nil;
    if (stringArray.count > 1)  //  有多个
    {
        NSMutableString *mutableString = TSAPI_TFSUrl.mutableCopy;
        [mutableString appendString:realTFSKey];
        
        for(NSInteger i = 0;i < stringArray.count;i++)
        {
            if (i != 0) //  非第一个
            {
                if (i != stringArray.count - 1) //  非最后一个
                {
                    [mutableString appendString:@"."];
                    [mutableString appendString:stringArray[i]];
                }
                else    //  最后一个
                {
                    NSString *lastKeyComp = stringArray[i];
                    if ([lastKeyComp containsString:@"png"] || [lastKeyComp containsString:@"jpg"] || [lastKeyComp containsString:@"gif"] || [lastKeyComp containsString:@"jpeg"] || [lastKeyComp containsString:@"bmp"])   //  图片后缀
                    {
                        lastKeyComp = stringArray[i];
                    }
                    else    //  非图片后缀
                    {
                        [mutableString appendString:@"."];
                        [mutableString appendString:stringArray[i]];
                        
                        lastKeyComp = @"png";
                    }
                    [mutableString appendString:[NSString stringWithFormat:@"_%zdx%zd.%@",width,height,lastKeyComp]];
                }
            }
        }
        
        string = mutableString.copy;
    }
    else    //  只有一个
    {
        string = [NSString stringWithFormat:@"%@%@_%zdx%zd.png",TSAPI_TFSUrl,realTFSKey,width,height];
    }

    [self sd_setImageWithURL:[NSURL URLWithString:string]
            placeholderImage:placeHolderImage
                   completed:NULL];
}

- (void)TSLoadAvertWithTFSKey:(NSString *)tfsKey
{
    
    self.contentMode = UIViewContentModeScaleToFill;
    
    [self sd_setImageWithURL:[NSURL URLWithString:tfsKey] placeholderImage:[UIImage imageNamed:@"testHeader"] completed:NULL];

    
//    [self sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TSAPI_TFSUrl,tfsKey]] placeholderImage:[UIImage imageNamed:@"testHeader"] completed:NULL];
    
}
@end
