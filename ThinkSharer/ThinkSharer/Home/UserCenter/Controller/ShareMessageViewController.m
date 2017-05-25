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

@interface ShareMessageViewController ()<UITableViewDelegate,UITableViewDataSource,CTAssetsPickerControllerDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate>

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


@end

@implementation ShareMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBar];
    
    _responderTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_responderTextField];
    
    [self configBirthdayPickerView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeLineColor) name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark UI
- (void)setNavigationBar {
    [self setNavigationBarTitle:@"思享者信息"];
    [self setNavigationBarBack];
    [self initUI];
}

- (void)initUI {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:(UITableViewStylePlain)];
    }
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self initTableHeaderView];
    
    
}

- (void)initTableHeaderView {
    
    _tableHeaderView = [[ShareMessageTableHeaderView alloc]init];
    
    _tableView.tableHeaderView = _tableHeaderView;
    _tableHeaderView.nickTextFiled.delegate = self;

    TSWeakSelf
    
    _tableHeaderView.SelectPhotoBlock = ^{
        [weakSelf selectPhoto];
    };
    
    _tableHeaderView.SelectBirthdatBlock = ^{
        [weakSelf selectBirthday];
    };
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

#pragma mark - UIImagePickerController delegate -

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    NSString *type = info[UIImagePickerControllerMediaType];
    NSString *tmpStr = (NSString *)kUTTypeImage;
    
    if ([type isEqualToString:tmpStr]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        
        _tableHeaderView.headerImageView.image = image;
        __block NSString *createdAssetID =nil;//唯一标识，可以用于图片资源获取
        NSError *error =nil;
        [[PHPhotoLibrary sharedPhotoLibrary]performChangesAndWait:^{
            createdAssetID = [PHAssetChangeRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset.localIdentifier;
        } error:&error];
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)configBirthdayPickerView {
    _birthdayPickerView = [[UIDatePicker alloc] init];
    _birthdayPickerView.backgroundColor = [UIColor whiteColor];
    _birthdayPickerView.datePickerMode = UIDatePickerModeDate;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [calendar setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:0];
    [comps setMonth:0];
    [comps setDay:0];
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    [comps setYear:-120];
    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    _birthdayPickerView.maximumDate = maxDate;
    _birthdayPickerView.minimumDate = minDate;
    _birthdayPickerView.calendar = calendar;
    
    _birthdayToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    _birthdayToolBar.barTintColor = [UIColor whiteColor];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(toolBarCancleButtonClicked)];
    leftItem.tintColor = [UIColor generalSubTitleFontGrayColor];
    UIBarButtonItem *centerSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(birthdayToolBarDoneButtonClicked)];
    rightItem.tintColor = [UIColor mainColorBlue];
    _birthdayToolBar.items=@[leftItem, centerSpace, rightItem];
    

}

- (void)selectBirthday {
    
    [self.view addSubview:self.maskView];
    [_birthdayToolBar addSubview:self.separatorView];
    _responderTextField.inputAccessoryView = _birthdayToolBar;
    _responderTextField.inputView = _birthdayPickerView;
    [_responderTextField becomeFirstResponder];
}

//取消
- (void)toolBarCancleButtonClicked {
    [_responderTextField resignFirstResponder];
    [self.maskView removeFromSuperview];
}
//确定
- (void)birthdayToolBarDoneButtonClicked {
    [self toolBarCancleButtonClicked];
    
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:_birthdayPickerView.date];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:_birthdayPickerView.date];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate *destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:_birthdayPickerView.date];
    
    self.birthday = [[NSString stringWithFormat:@"%@",destinationDateNow] substringToIndex:10];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
//    NSDate *reallyDate = [dateformatter dateFromString:self.birthday];
    
    NSLog(@"%@",self.birthday);
    
    [_tableHeaderView setBirthdayString:self.birthday];
    
}

#pragma mark - setter && getter
//工具栏的分割线
- (UIView *)separatorView {
    if (_separatorView == nil) {
        _separatorView = [[UIView alloc] init];
        _separatorView.frame = CGRectMake(0, 44 - 1, ScreenWidth, 1);
        _separatorView.backgroundColor = [UIColor mainColorBlue];
    }
    return _separatorView;
}

//遮罩视图
- (UIView *)maskView {
    if (_maskView == nil) {
        _maskView = [[UIView alloc] initWithFrame:self.view.bounds];
        _maskView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
        [_maskView addGestureRecognizer:self.tapGestureRecognizer];
    }
    return _maskView;
}

//手势
- (UITapGestureRecognizer *)tapGestureRecognizer {
    if (_tapGestureRecognizer == nil) {
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toolBarCancleButtonClicked)];
    }
    return _tapGestureRecognizer;
}

#pragma mark UITextFiledDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == _tableHeaderView.nickTextFiled) {
        _tableHeaderView.nickLine.backgroundColor = [UIColor mainColorBlue];
    }
    
    return YES;
}


#pragma mark UITableViewDelegate UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    
    return cell;
}

#pragma mark private Methoeds

- (void)changeLineColor {
    
    _tableHeaderView.nickLine.backgroundColor = [UIColor seperateThinLineColor];
    
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
