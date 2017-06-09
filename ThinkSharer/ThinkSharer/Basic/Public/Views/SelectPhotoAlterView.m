//
//  SelectPhotoAlterView.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/6.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "SelectPhotoAlterView.h"

@implementation SelectPhotoAlterView



- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, 156);
        self.backgroundColor = [UIColor clearColor];
        
        UILabel *photoLibiaryLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        [self addSubview:photoLibiaryLabel];
        photoLibiaryLabel.backgroundColor = [UIColor whiteColor];
        photoLibiaryLabel.textAlignment = NSTextAlignmentCenter;
        photoLibiaryLabel.font = [UIFont systemFontOfSize:15];
        photoLibiaryLabel.textColor = [UIColor generalTitleFontBlackColor];
        photoLibiaryLabel.userInteractionEnabled = YES;
        photoLibiaryLabel.text = @"从相册选择图片";
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMethod:)];
        [photoLibiaryLabel addGestureRecognizer:tap];
        
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, photoLibiaryLabel.bottom, ScreenWidth, 0.5)];
        [self addSubview:line];
        line.backgroundColor = [UIColor seperateThinLineColor];
        
        UILabel *takePhotoLable = [[UILabel alloc]initWithFrame:CGRectMake(0, line.bottom, ScreenWidth, 50)];
        [self addSubview:takePhotoLable];
        takePhotoLable.backgroundColor = [UIColor whiteColor];
        takePhotoLable.textAlignment = NSTextAlignmentCenter;
        takePhotoLable.font = [UIFont systemFontOfSize:15];
        takePhotoLable.textColor = [UIColor generalTitleFontBlackColor];
        takePhotoLable.userInteractionEnabled = YES;
        takePhotoLable.text = @"拍照";

        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMethod1:)];
        [takePhotoLable addGestureRecognizer:tap1];

        
        UILabel *cancleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, takePhotoLable.bottom + 5, ScreenWidth, 50)];
        [self addSubview:cancleLabel];
        cancleLabel.backgroundColor = [UIColor whiteColor];
        cancleLabel.textAlignment = NSTextAlignmentCenter;
        cancleLabel.font = [UIFont systemFontOfSize:15];
        cancleLabel.textColor = [UIColor generalTitleFontBlackColor];
        cancleLabel.userInteractionEnabled = YES;
        cancleLabel.text = @"取消";

        
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMethod2:)];
        [cancleLabel addGestureRecognizer:tap2];

        
    }
    return self;
}

- (void)tapMethod:(UITapGestureRecognizer *)tap {
    self.SelectPhotoBlock(SelectPhotoTypeByLibrary);
}

- (void)tapMethod1:(UITapGestureRecognizer *)tap {
    self.SelectPhotoBlock(SelectPhotoTypeByTakePhoto);

}

- (void)tapMethod2:(UITapGestureRecognizer *)tap {
    self.SelectPhotoBlock(SelectPhotoTypeCancle);

}



@end
