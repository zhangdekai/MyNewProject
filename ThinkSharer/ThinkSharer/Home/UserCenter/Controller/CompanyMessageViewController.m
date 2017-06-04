//
//  CompanyMessageViewController.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/4.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "CompanyMessageViewController.h"
#import "CompanyTableHeaderView.h"


#import "CTAssetsPickerController.h"
#import "ShareMessageTableHeaderView.h"
#import <Photos/Photos.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "TSDatePickerView.h"
#import "ThinkSharer-Swift.h"
#import "ShareMessageFirstCell.h"
#import "ShareMessageSecondCell.h"
#import "ShareMessageThirdCell.h"
#import "ShareMessageFourthCell.h"



@interface CompanyMessageViewController ()<UITableViewDelegate,UITableViewDataSource,CTAssetsPickerControllerDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UITextViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) CompanyTableHeaderView *tableHeaderView;

@end

@implementation CompanyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
}

- (void)setNavigationBar {
    [self setNavigationBarTitle:@"机构信息"];
    [self setNavigationBarBack];
    TSWeakSelf
    [self setNavigationBarRightItemWithTitle:@"保存" itemBlock:^{
        NSLog(@"%@",@"sdfsd");
    
    }];
}

- (void)initUI {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:(UITableViewStylePlain)];
    }
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerClass:[ShareMessageFirstCell class] forCellReuseIdentifier:@"ShareMessageFirstCell"];
    [_tableView registerClass:[ShareMessageSecondCell class] forCellReuseIdentifier:@"ShareMessageSecondCell"];
    [_tableView registerClass:[ShareMessageThirdCell class] forCellReuseIdentifier:@"ShareMessageThirdCell"];
    [_tableView registerClass:[ShareMessageFourthCell class] forCellReuseIdentifier:@"ShareMessageFourthCell"];
    
    
    
    [self initTableHeaderView];
    [self initTableFooterView];
    
}

- (void)initTableHeaderView {
    
    _tableHeaderView = [[CompanyTableHeaderView alloc]init];
    
    _tableView.tableHeaderView = _tableHeaderView;
    
    TSWeakSelf
    _tableHeaderView.SelectPhotoBlock = ^{
        [weakSelf selectPhoto];
    };
    
}

- (void)initTableFooterView {
    ShareMessageTableFooterView *footer = [[ShareMessageTableFooterView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
    _tableView.tableFooterView = footer;
    
}

- (void)selectPhoto {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openCamer];
    }];
    
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openPhoto];
        
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
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
        for (NSInteger i = 0; i < assets.count; i++) {
            PHAsset *asset = assets[i];
            CGSize size = CGSizeMake(asset.pixelWidth / scale, asset.pixelHeight / scale);
            
            /** 获取图片*/
            [[PHImageManager defaultManager] requestImageForAsset:asset
                                                       targetSize:size
                                                      contentMode:PHImageContentModeDefault
                                                          options:options
                                                    resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                        
                                                        //                                                        [self.imageArray removeLastObject];
                                                        //                                                        [self.imageArray addObject:result];
                                                        //                                                        /** 刷新*/
                                                        //                                                        [self reload];
                                                        
                                                        
                                                    }];
        }
    }];
    NSLog(@"选择的照片");
    
}


#pragma mark - UIImagePickerController delegate -

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    NSString *type = info[UIImagePickerControllerMediaType];
    NSString *tmpStr = (NSString *)kUTTypeImage;
    
    if ([type isEqualToString:tmpStr]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        
        _tableHeaderView.headerImageView.image = image;
        __block NSString *createdAssetID =nil;//唯一标识，可以用于图片资源获取  保存到系统相册
        NSError *error =nil;
        [[PHPhotoLibrary sharedPhotoLibrary]performChangesAndWait:^{
            createdAssetID = [PHAssetChangeRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset.localIdentifier;
        } error:&error];
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
