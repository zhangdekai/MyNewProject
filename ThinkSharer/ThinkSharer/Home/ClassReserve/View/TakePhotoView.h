//
//  TakePhotoView.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/14.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TakePhotoView : NSObject

@property (nonatomic, strong) UIImageView  * cameraShowView;
//放置预览图层的View

- (void)startTakePhoto;

- (void)stopTakePhoto ;


@end
