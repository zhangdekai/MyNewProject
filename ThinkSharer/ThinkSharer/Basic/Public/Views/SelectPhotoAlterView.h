//
//  SelectPhotoAlterView.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/6.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SelectPhotoType) {
    SelectPhotoTypeByLibrary,
    SelectPhotoTypeByTakePhoto,
    SelectPhotoTypeCancle,
};


@interface SelectPhotoAlterView : UIView

@property (nonatomic,copy) void (^SelectPhotoBlock) (SelectPhotoType type);

@end
