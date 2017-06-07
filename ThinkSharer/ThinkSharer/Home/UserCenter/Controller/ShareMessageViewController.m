//
//  ShareMessageViewController.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/24.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "ShareMessageViewController.h"
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
#import "ThinkSharer-Swift.h"
#import "IdentityIdentificatesViewController.h"


@interface ShareMessageViewController ()<UITableViewDelegate,UITableViewDataSource,CTAssetsPickerControllerDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UITextViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) ShareMessageTableHeaderView *tableHeaderView;


//滚动选择
@property (nonatomic, strong) UIPickerView *sexPickerView;
@property (nonatomic, strong) UIToolbar *sexToolBar;
@property (nonatomic, strong) UIDatePicker *birthdayPickerView;
@property (nonatomic, strong) UIToolbar *birthdayToolBar;;
@property (nonatomic, strong) UIPickerView *liveStationPickerView;
@property (nonatomic, strong) UIToolbar *liveStationToolBar;
@property (nonatomic, strong) UITextField *responderTextField;
@property (nonatomic, strong) UIView *separatorView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@property (nonatomic, strong) NSString *birthday;

@property (nonatomic,assign) NSInteger number;

//weak tmp
@property (nonatomic,weak) UITextView *tmpTextView;
@property (nonatomic,weak) UILabel *tmpLabel;//数字
@property (nonatomic,weak) UITextField *workPlaceTextField;
@property (nonatomic,weak) UITextField *workNameTextField;
@property (nonatomic,weak) UITextField *graduationSchoolTextField;
@property (nonatomic,weak) UITextField *majorTextField;
@property (nonatomic,weak) UITextField *educationBackgroundTextField;



@property (nonatomic,assign) NSInteger sctionOne;
@property (nonatomic,strong) NSMutableArray *sctionTwoArray;
@property (nonatomic,assign) NSInteger sctionThree;
@property (nonatomic,assign) NSInteger sctionFource;
@property (nonatomic,assign) NSInteger sctionFive;


@property (nonatomic,copy) NSArray *sctionThreeArray;
@property (nonatomic,copy) NSArray *sctionFourceArray;
@property (nonatomic,copy) NSArray *sctionfiveArray;
@property (nonatomic,copy) NSArray *sctionfiveArray1;

@property (nonatomic,copy) NSString *sexString;//性别



@end

@implementation ShareMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.userInteractionEnabled = YES;
    [self setNavigationBar];
    [self initUI];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeLineColor) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardShow) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardHidden) name:UIKeyboardWillHideNotification object:nil];
    
    
}

- (void)dealloc {
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)initData {
    _sctionOne = 0;
    _sctionTwoArray = [NSMutableArray arrayWithObjects:@"蓝色的看法你来说可能疯了快十年来反馈是你生生世世",@"善良的空间里发生困难都流口水",@"基本上看到节省空间的",@"蓝色的看法你来说可能疯了快十年来反馈是你生生世世", nil];
    _sctionThree = 0;
    _sctionFource = 0;
    _sctionFive = 0;
    
    _sctionThreeArray = @[@"行业信息：",@"工作单位：",@"专业职称："];
    _sctionFourceArray = @[@"毕业院校：",@"所学专业：",@"学历学位："];
    _sctionfiveArray = @[@"身份证认证",@"毕业证认证",@"教师证认证",@"其他资质认证"];
    _sctionfiveArray1 = @[@"已认证",@"认证中",@"未认证",@""];
    
    
}



#pragma mark UI
- (void)setNavigationBar {
    [self setNavigationBarTitle:@"个人信息"];
    [self setNavigationBarBack];
    TSWeakSelf
    [self setNavigationBarRightItemWithTitle:@"保存" itemBlock:^{
        
        NSLog(@"昵称：%@ sex :%@  生日： %@  简介：%@  工作单位：%@   专业职称：%@ 毕业院校：%@  所学专业：%@  学历学位：%@",weakSelf.tableHeaderView.nickTextFiled.text,weakSelf.sexString,weakSelf.birthday,weakSelf.tmpTextView.text,weakSelf.workPlaceTextField.text,weakSelf.workNameTextField.text,weakSelf.graduationSchoolTextField.text,weakSelf.majorTextField.text,weakSelf.educationBackgroundTextField.text);
    }];
}

- (void)initUI {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:(UITableViewStyleGrouped)];
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

//重写获得photos
- (void)selectedPhoto:(NSArray *)photos {
    for (UIImage *image in photos) {
        self.tableHeaderView.headerImageView.image = image;
    }
}

- (void)initTableHeaderView {
    
    _tableHeaderView = [[ShareMessageTableHeaderView alloc]init];
    
    _tableView.tableHeaderView = _tableHeaderView;
    _tableHeaderView.nickTextFiled.delegate = self;

    TSWeakSelf
    
//    [self ]
    
    _tableHeaderView.SelectPhotoBlock = ^{
        [weakSelf selectPhoto];
    };
    
   
    
    
    _tableHeaderView.SelectBirthdatBlock = ^{
        [weakSelf selectBirthday];
    };
    
    _tableHeaderView.SelectSexBlock = ^(NSString *sex) {
        NSLog(@"%@",sex);
        weakSelf.sexString = sex;
    };
}

- (void)initTableFooterView {
    ShareMessageTableFooterView *footer = [[ShareMessageTableFooterView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
    _tableView.tableFooterView = footer;
    
}

#pragma mark UITableViewDelegate UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return _sctionOne;
            break;
        case 1:
            return _sctionTwoArray.count;
            break;
        case 2:
            if (_sctionThree > 0) {
                return 3;
            }
            return 0;
            break;
        case 3:
            if (_sctionFource > 0) {
                return 3;
            }
            return 0;
            break;
        case 4:
            if (_sctionFive > 0) {
                return 4;
            }
            return 0;
            break;
            
        default:
            return 0;

            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            if (_sctionOne == 1) {
                return 110;
            }
            return 0;
            break;
        case 1:
            if (_sctionTwoArray.count > 0) {
                NSString *tmp = _sctionTwoArray[indexPath.row];
                CGFloat height = [TSPublicTool sizeWithString:tmp font:[UIFont systemFontOfSize:15] width:ScreenWidth - 80].height;
                

                return height + 30;
            }
            return 0;
            break;
        case 2:
            if (_sctionThree > 0) {
                return 50;
            }
            return 0;
            break;
        case 3:
            if (_sctionFource > 0) {
                return 50;
            }
            return 0;
            break;
        case 4:
            if (_sctionFive > 0) {
                return 50;
            }
            return 0;
            break;
        default:
            return 0;
            
            break;
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{//简介
            ShareMessageFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShareMessageFirstCell"];
           
            _tmpTextView = cell.textView;
            _tmpLabel = cell.numLabel;
            _tmpTextView.delegate = self;
            return cell;
        }
            break;
        case 1:{//地址信息
            ShareMessageSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShareMessageSecondCell"];
            if (_sctionTwoArray.count > 0) {
                [cell setAddressModel:_sctionTwoArray[indexPath.row]];
            }
            
            return cell;
        }
            break;
        case 2:{//职业信息
            if (indexPath.row == 0) {
                ShareMessageFourthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShareMessageFourthCell"];
                cell.leftLabel.text = _sctionThreeArray[indexPath.row];
                return cell;
            }
            ShareMessageThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShareMessageThirdCell"];
            cell.leftLabel.text = _sctionThreeArray[indexPath.row];
            cell.rightTextFiled.delegate = self;
            if (indexPath.row == 1) {
                _workPlaceTextField = cell.rightTextFiled;
            } else {
                _workNameTextField = cell.rightTextFiled;
            }

            return cell;
        }
            break;
        case 3:{//教育经历
            ShareMessageThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShareMessageThirdCell"];
            cell.leftLabel.text = _sctionFourceArray[indexPath.row];
            cell.rightTextFiled.delegate = self;
            if (indexPath.row == 0) {
                _graduationSchoolTextField = cell.rightTextFiled;
            } else if (indexPath.row == 1) {
                _majorTextField = cell.rightTextFiled;
            }  else {
                _educationBackgroundTextField = cell.rightTextFiled;
            }
            
            return cell;
        }
            break;
            
        case 4:{//资质认证
            ShareMessageFourthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShareMessageFourthCell"];
            cell.leftLabel.text = _sctionfiveArray[indexPath.row];
            [cell setRightButtonString:_sctionfiveArray1[indexPath.row]];
            return cell;
        }
            break;


            
        default:{
            UITableViewCell *cell = [[UITableViewCell alloc]init];
            return cell;
        }
            
            break;
    }

}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    ShareMessageSectionView *header = [[ShareMessageSectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    TSWeakSelf
    switch (section) {
        case 0:{
            
            BOOL open = _sctionOne == 1 ? YES:NO;
            [header setRightImageWithOpen:open];
            header.openOrCloseBlock = ^(BOOL open) {
                if (open) {
                    _sctionOne = 0;
                } else {
                    _sctionOne = 1;
                }
                NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
                [weakSelf.tableView reloadSections:indexSet withRowAnimation:(UITableViewRowAnimationAutomatic)];
            };
        }
            break;
        case 1:{
            
            header.leftLabel.text = @"地址信息";
            header.rightIcon.image = [UIImage imageNamed:@"userMessage_add"];
            header.rightIcon.size = CGSizeMake(15, 15);
            header.addAddressBlock = ^{
                if (weakSelf.sctionTwoArray.count > 5) {
                    return ;
                }
                [weakSelf.sctionTwoArray addObject:@"六十多年历史的那份快乐思念对方离开你"];
                NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
                [weakSelf.tableView reloadSections:indexSet withRowAnimation:(UITableViewRowAnimationAutomatic)];
            };
            
        }
            break;
            
        case 2:{
            
            header.leftLabel.text = @"职业信息";
            BOOL open = _sctionThree > 0 ? YES:NO;
            [header setRightImageWithOpen:open];
            header.openOrCloseBlock = ^(BOOL open) {
                if (open) {
                    _sctionThree = 0;
                } else {
                    _sctionThree = 3;
                }
                NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
                [weakSelf.tableView reloadSections:indexSet withRowAnimation:(UITableViewRowAnimationAutomatic)];
            };
            
        }
            break;
            
        case 3:{
            
            header.leftLabel.text = @"教育经历";
            BOOL open = _sctionFource > 0 ? YES:NO;
            [header setRightImageWithOpen:open];
            header.openOrCloseBlock = ^(BOOL open) {
                if (open) {
                    _sctionFource = 0;
                } else {
                    _sctionFource = 3;
                }
                NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
                [weakSelf.tableView reloadSections:indexSet withRowAnimation:(UITableViewRowAnimationAutomatic)];
            };
            
        }
            break;
        case 4:{
            
            header.leftLabel.text = @"资质认证";
            BOOL open = _sctionFive > 0 ? YES:NO;
            [header setRightImageWithOpen:open];
            header.openOrCloseBlock = ^(BOOL open) {
                if (open) {
                    _sctionFive = 0;
                } else {
                    _sctionFive = 4;
                }
                NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
                [weakSelf.tableView reloadSections:indexSet withRowAnimation:(UITableViewRowAnimationAutomatic)];
            };
            
        }
            break;

        default:
            break;
    }
    
    
    return header;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return YES;

    }
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_sctionTwoArray removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    footer.backgroundColor = [UIColor backgroundGrayColorA];
    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 4 && indexPath.row == 0) {//身份证认证
        IdentityIdentificatesViewController *vc = [[IdentityIdentificatesViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark UITextViewDelegate 
- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 10) {
        textView.text = [textView.text substringToIndex:10];
    }
    _tmpLabel.text = [NSString stringWithFormat:@"%ld",(10 - textView.text.length)];
}

#pragma mark private Methoeds

- (void)keyBoardShow {
    
    _tableView.frame = CGRectMake(0, -100, ScreenWidth, ScreenHeight);
}

- (void)keyBoardHidden {
    _tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
}


- (void)changeLineColor {
    _tableHeaderView.nickLine.backgroundColor = [UIColor seperateThinLineColor];
}


//#pragma mark 相册选择
///** 打开相册*/
//- (void)openPhoto {
//    /** 判断当前授权状态*/
//    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
//    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
//        switch (status) {
//            case PHAuthorizationStatusRestricted:    /** 系统级别的控制(如家长控制)*/
//                break;
//            case PHAuthorizationStatusDenied:    /** 用户选择了取消*/
//                if (oldStatus != PHAuthorizationStatusNotDetermined) {
//                    break;
//                }
//                break;
//            case PHAuthorizationStatusAuthorized:    /** 当前用户允许app访问相册*/
//                [self choosePhotos];
//            default:
//                break;
//        }
//    }];
//}
//
///** 选择图片*/
//- (void)choosePhotos {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
//        
//        picker.showsSelectionIndex = YES;
//        
//        picker.delegate = self;
//        
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//            picker.modalPresentationStyle = UIModalPresentationFormSheet;
//        }
//        
//        [self presentViewController:picker animated:YES completion:nil];
//        
//    });
//}
//
//#pragma mark CTAssetsPickerControllerDelegate
//- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
//{
//    /** 关闭图片选择控制器*/
//    [picker dismissViewControllerAnimated:YES completion:^{
//        CGFloat scale = [UIScreen mainScreen].scale;
//        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
//        options.resizeMode = PHImageRequestOptionsResizeModeExact;
//        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
//        
//        /** 遍历选择的所有图片*/
//        for (NSInteger i = 0; i < assets.count; i++) {
//            PHAsset *asset = assets[i];
//            CGSize size = CGSizeMake(asset.pixelWidth / scale, asset.pixelHeight / scale);
//            
//            /** 获取图片*/
//            [[PHImageManager defaultManager] requestImageForAsset:asset
//                                                       targetSize:size
//                                                      contentMode:PHImageContentModeDefault
//                                                          options:options
//                                                    resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
//                                                        
//                                                        //                                                        [self.imageArray removeLastObject];
//                                                        //                                                        [self.imageArray addObject:result];
//                                                        //                                                        /** 刷新*/
//                                                        //                                                        [self reload];
//                                                        
//                                                        
//                                                    }];
//        }
//    }];
//    NSLog(@"选择的照片");
//    
//}
//
//- (void)selectPhoto {
//    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
//        
//    }];
//    
//    
//    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self openCamer];
//    }];
//    
//    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self openPhoto];
//        
//    }];
//    
//    [alertController addAction:cancelAction];
//    [alertController addAction:deleteAction];
//    [alertController addAction:archiveAction];
//    
//    [self presentViewController:alertController animated:YES completion:nil];
//    
//}
//
//- (void)openCamer {
//    
//    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//    if (status == AVAuthorizationStatusDenied)
//    {
//        
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法访问相机" message:@"请在iPhone的\"设置-隐私-相机\"选项中,允许思享者访问你的手机相机" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *leftAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            [self.navigationController popViewControllerAnimated:YES];
//        }];
//        [alertController addAction:leftAction];
//        [self presentViewController:alertController animated:YES completion:nil];
//        return;
//    }
//    
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//    {
//        UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
//        photoPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        photoPicker.modalPresentationStyle = UIModalPresentationFullScreen;
//        photoPicker.delegate = (id)self;
//        photoPicker.allowsEditing = NO;
//        
//        photoPicker.mediaTypes = @[(NSString *)kUTTypeImage];
//        [self presentViewController:photoPicker animated:YES completion:NULL];
//    }
//    
//}
//
//#pragma mark - UIImagePickerController delegate -
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
//    
//    NSString *type = info[UIImagePickerControllerMediaType];
//    NSString *tmpStr = (NSString *)kUTTypeImage;
//    
//    if ([type isEqualToString:tmpStr]) {
//        UIImage *image = info[UIImagePickerControllerOriginalImage];
//        
//        _tableHeaderView.headerImageView.image = image;
//        __block NSString *createdAssetID =nil;//唯一标识，可以用于图片资源获取  保存到系统相册
//        NSError *error =nil;
//        [[PHPhotoLibrary sharedPhotoLibrary]performChangesAndWait:^{
//            createdAssetID = [PHAssetChangeRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset.localIdentifier;
//        } error:&error];
//        
//    }
//    
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}
//


- (void)selectBirthday {
    [self.view endEditing:YES];
    TSDatePickerView *date = [[TSDatePickerView alloc]init];
    
    [date showInView];
    TSWeakSelf
    date.TSDatePickerBlock = ^(NSString *date) {
        [weakSelf.tableHeaderView.birthdayButton setTitle:date forState:(UIControlStateNormal)];
        weakSelf.birthday = date;
        NSLog(@"%@",date);
    };
    
}


#pragma mark UITextFiledDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == _tableHeaderView.nickTextFiled) {
        _tableHeaderView.nickLine.backgroundColor = [UIColor mainColorBlue];
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

