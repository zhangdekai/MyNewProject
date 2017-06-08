//
//  BasicViewController+TSTakePhotos.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/5.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "BasicViewController+TSTakePhotos.h"
#import "CTAssetsPickerController.h"
#import <Photos/Photos.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "SelectPhotoAlterView.h"
#import <PYPhotoBrowser/PYPhotoBrowser.h>


@interface BasicViewController ()<CTAssetsPickerControllerDelegate>


@end

@implementation BasicViewController (TSTakePhotos)

#pragma mark 相册选择

- (void)selectPhoto:(NSInteger)maxNum {
    self.selectPhotoMaxNum = maxNum;
    SelectPhotoAlterView *container = [[SelectPhotoAlterView alloc]init];
    
    TSAlterShowView *alterView = [[TSAlterShowView alloc]init];
    
    [alterView creatContainerView:container];
    
    [alterView showView];
    
    container.SelectPhotoBlock = ^(SelectPhotoType type) {
        switch (type) {
            case SelectPhotoTypeByLibrary:
                [self openPhoto];
                break;
            case SelectPhotoTypeByTakePhoto:
                [self openCamer];
                break;
            case SelectPhotoTypeCancle:
                break;
            default:
                break;
        }
        [alterView hiddenAlter];
    };

}

- (void)browerPhotos:(NSArray<UIImageView *> *)photoImageViews touchIndex:(NSInteger)index {
    // 1. 创建photoBroseView对象
    PYPhotoBrowseView *photoBroseView = [[PYPhotoBrowseView alloc] init];
    
    // 2.1 设置图片源(UIImageView)数组
    photoBroseView.sourceImgageViews = photoImageViews;
    
    // 2.2 设置初始化图片下标（即当前点击第几张图片）
    photoBroseView.currentIndex = index;
    
    // 3.显示(浏览)
    [photoBroseView show];
}

- (void)browerPhotosByUIImage:(NSArray<UIImage *> *)photoImages touchIndex:(NSInteger)index {
    
    // 1. 创建photoBroseView对象
    PYPhotoBrowseView *photoBroseView = [[PYPhotoBrowseView alloc] init];
    
    // 2.1 设置图片源(UIImage)数组
    photoBroseView.images = photoImages;
    
    photoBroseView.frameFormWindow = CGRectMake(0, 0, 0, 0);
    photoBroseView.frameToWindow = CGRectMake(0, 0, 0, 0);
    
    // 2.2 设置初始化图片下标（即当前点击第几张图片）
    photoBroseView.currentIndex = index;
    
    // 3.显示(浏览)
    [photoBroseView show];
}




/** 打开相册*/
- (void)openPhoto {
    /** 判断当前授权状态*/
    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        switch (status) {
            case PHAuthorizationStatusRestricted:    /** 系统级别的控制(如家长控制)*/
                break;
            case PHAuthorizationStatusDenied:    /** 用户选择了取消*/
                if (oldStatus != PHAuthorizationStatusNotDetermined) {
                    break;
                }
                break;
            case PHAuthorizationStatusAuthorized:    /** 当前用户允许app访问相册*/
                [self choosePhotos];
            default:
                break;
        }
    }];
}

/** 选择图片*/
- (void)choosePhotos {
    dispatch_async(dispatch_get_main_queue(), ^{
        CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
        
        picker.showsSelectionIndex = YES;
        if (self.selectedAssets) {
            picker.selectedAssets = self.selectedAssets;

        }
        picker.delegate = self;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            picker.modalPresentationStyle = UIModalPresentationFormSheet;
        }
        
        [self presentViewController:picker animated:YES completion:nil];
        
    });
}

#pragma mark CTAssetsPickerControllerDelegate
- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    /** 关闭图片选择控制器*/
    [picker dismissViewControllerAnimated:YES completion:^{
        CGFloat scale = [UIScreen mainScreen].scale;
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.resizeMode = PHImageRequestOptionsResizeModeExact;
        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        
        /** 遍历选择的所有图片*/
        NSMutableArray *images = [NSMutableArray array];
        for (NSInteger i = 0; i < assets.count; i++) {
            PHAsset *asset = assets[i];
            CGSize size = CGSizeMake(asset.pixelWidth / scale, asset.pixelHeight / scale);
            
            /** 获取图片*/
            [[PHImageManager defaultManager]
             requestImageForAsset:asset
                       targetSize:size
                      contentMode:PHImageContentModeDefault
                          options:options
             resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                 [images addObject:result];
                 if (images.count == assets.count) {
                     [self selectedPhoto:images];
                 }
            }];
        }
    }];
    NSLog(@"选择的照片");
    
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(PHAsset *)asset {
    if (self.selectPhotoMaxNum == 0) {
        return YES;
    }
    if (picker.selectedAssets.count >= self.selectPhotoMaxNum) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:picker.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = [NSString stringWithFormat:@"最多能加%ld张照片",self.selectPhotoMaxNum];
        
        [hud hideAnimated:YES afterDelay:1.5];
        
        return NO;
    }
    self.selectedAssets = picker.selectedAssets;
    
    return YES;
}

- (void)selectedPhoto:(NSArray<UIImage *> *)photos {
    
}


- (void)openCamer {
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusDenied)
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法访问相机" message:@"请在iPhone的\"设置-隐私-相机\"选项中,允许思享者访问你的手机相机" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *leftAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:leftAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
        photoPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        photoPicker.modalPresentationStyle = UIModalPresentationFullScreen;
        photoPicker.delegate = (id)self;
        photoPicker.allowsEditing = NO;
        
        photoPicker.mediaTypes = @[(NSString *)kUTTypeImage];
        [self presentViewController:photoPicker animated:YES completion:NULL];
    }
    
}

#pragma mark - UIImagePickerController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    NSString *type = info[UIImagePickerControllerMediaType];
    NSString *tmpStr = (NSString *)kUTTypeImage;
    
    if ([type isEqualToString:tmpStr]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        
        //        _tableHeaderView.headerImageView.image = image;
        __block NSString *createdAssetID =nil;//唯一标识，可以用于图片资源获取  保存到系统相册
        NSError *error =nil;
        [[PHPhotoLibrary sharedPhotoLibrary]performChangesAndWait:^{
            createdAssetID = [PHAssetChangeRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset.localIdentifier;
        } error:&error];
        
        [self takedPhoto:image];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)takedPhoto:(UIImage *)photo {
    
}



@end
