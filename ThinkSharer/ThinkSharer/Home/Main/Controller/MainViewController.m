//
//  MainViewController.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/16.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "MainViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "ClassListViewController.h"
#import "SharerCenterViewController.h"
#import "SearchClassViewController.h"
#import "TSActionAlterView.h"
#import "TSAppInfo.h"

@interface MainViewController ()<MAMapViewDelegate,AMapLocationManagerDelegate>

@property (nonatomic,strong) MAMapView *mapView;
//@property (nonatomic,strong) CLLocationManager *locationManager;

@property (nonatomic,strong) AMapLocationManager *locationManager;
@property (nonatomic,strong) NSMutableArray *AnnotationArray;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //    定位授权
    
    [self showAlterView];
    
    [self judgeLocationWhetherOpen];
//    _locationManager = [[CLLocationManager alloc]init];
//    [_locationManager requestWhenInUseAuthorization];
    
    
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;

    //高德地图
    [AMapServices sharedServices].apiKey = AMapKey;
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    
    ///初始化地图
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mapView];
    
 
    self.mapView.delegate = self;
    
    
    self.mapView.showsCompass = NO;
    self.mapView.showsScale = NO;
    self.mapView.rotateEnabled = NO;
    [self.mapView setZoomLevel:15 animated:YES];
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;

    
    [self addStartImage];

    
    //创建坐标
    CLLocationCoordinate2D coor ;
    coor.latitude = 39.92025581;
    coor.longitude = 116.45649116;
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    
    pointAnnotation.coordinate = coor;
    
    
    //创建坐标
    CLLocationCoordinate2D coor1 ;
    coor1.latitude = 39.93025581;
    coor1.longitude = 116.45649116;
    
    MAPointAnnotation *pointAnnotation1 = [[MAPointAnnotation alloc] init];
    
    pointAnnotation1.coordinate = coor1;
    
    //创建坐标
    CLLocationCoordinate2D coor2 ;
    coor2.latitude = 39.94025581;
    coor2.longitude = 116.45649116;
    
    MAPointAnnotation *pointAnnotation2 = [[MAPointAnnotation alloc] init];
    
    pointAnnotation2.coordinate = coor2;

    //创建坐标
    CLLocationCoordinate2D coor3 ;
    coor3.latitude = 39.94025581;
    coor3.longitude = 115.45649116;
    
    MAPointAnnotation *pointAnnotation3 = [[MAPointAnnotation alloc] init];
    
    pointAnnotation3.coordinate = coor3;
    
    //设置地图的定位中心点坐标
//    self.mapView.centerCoordinate = self.mapView.userLocation.location;
    //将点添加到地图上，即所谓的大头针
    
    NSArray *annotationArray = [NSArray arrayWithObjects:pointAnnotation,pointAnnotation1,pointAnnotation2,pointAnnotation3, nil];
    [self.mapView addAnnotations:annotationArray];
   
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
}


#pragma mark MAMapViewDelegate
/**
 * @brief 当mapView新添加annotation views时，调用此接口
 * @param mapView 地图View
 * @param views 新添加的annotation views
 */
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    
    NSLog(@"didAddAnnotationViews   %lu",(unsigned long)views.count);
    for (MAAnnotationView *customView in views) {
        NSLog(@"customView   %@",customView.reuseIdentifier);
        if ([customView.reuseIdentifier isEqualToString:@"MAUserLocationView"]) {
            
            NSLog(@"customView   %f",customView.annotation.coordinate.latitude);
            
            return;
        }

        customView.size = CGSizeMake(36, 36);
        
        UIImageView *header = [[UIImageView alloc]initWithFrame:(CGRectMake(2.5, 1.5, 36, 36))];
        header.image = [UIImage imageNamed:@"testHeader"];
        header.layer.cornerRadius = 18;
        header.layer.masksToBounds = YES;

        [customView addSubview:header];
        
        

        customView.image = [UIImage imageNamed:@"map_boy"];

    }
    
}



- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    
    NSLog(@"didSelectAnnotationView");
}

#pragma mark UI

- (void)addStartImage {
    //添加开始
    UIImageView *startImage = [[UIImageView alloc]init];
    [self.view addSubview:startImage];
//    startImage.frame = CGRectMake((ScreenWidth /2) - 30, ScreenHeight - 105, 80, 80);
    startImage.clipsToBounds = YES;
    [startImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(-25);
    }];
    
    startImage.layer.cornerRadius = 40;
    startImage.layer.masksToBounds = YES;
//    startImage.layer.borderWidth = 0.1;
    
    [[startImage layer]setShadowOffset:(CGSizeMake(0, 1))];
    [[startImage layer]setShadowRadius:1];
    [[startImage layer]setShadowOpacity:0.3];
    [[startImage layer]setShadowColor:[UIColor viewShaowColor].CGColor];

    
    startImage.image = [UIImage imageNamed:@"map_thinks"];
    startImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
    [singleTapGestureRecognizer setNumberOfTapsRequired:1];
    [startImage addGestureRecognizer:singleTapGestureRecognizer];
    
    UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
    [doubleTapGestureRecognizer setNumberOfTapsRequired:2];
    [startImage addGestureRecognizer:doubleTapGestureRecognizer];
    
    //这行很关键，意思是只有当没有检测到doubleTapGestureRecognizer 或者 检测doubleTapGestureRecognizer失败，singleTapGestureRecognizer才有效
    [singleTapGestureRecognizer requireGestureRecognizerToFail:doubleTapGestureRecognizer];
    
    
    //添加向右滑动尖头
    
    UIImageView *rightImage = [[UIImageView alloc]init];
    [self.view addSubview:rightImage];
    rightImage.frame = CGRectMake(ScreenWidth - 25 , 100, 25, 50);
    
    rightImage.image = [UIImage imageNamed:@"map_go"];
    rightImage.userInteractionEnabled = YES;
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goRight)];
    [rightImage addGestureRecognizer:tap];
}

#pragma mark private method
//发起单次定位
- (void)locateAgain {
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //   定位超时时间，最低2s，此处设置为2s
    self.locationManager.locationTimeout =2;
    //   逆地理请求超时时间，最低2s，此处设置为2s
    self.locationManager.reGeocodeTimeout = 2;
    
    
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    [self.locationManager requestLocationWithReGeocode:NO completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        NSLog(@"location:%@", location);
        self.mapView.centerCoordinate = location.coordinate;
        
        if (regeocode)
        {
            NSLog(@"reGeocode:%@", regeocode);
        }
    }];
}


- (void)goRight {
//    ClassListViewController *vc = [[ClassListViewController alloc]init];
//    vc.title = @"思享者中心";
//    [self.navigationController pushViewController:vc animated:YES];
    
    SharerCenterViewController *vc = [[SharerCenterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];


}

- (void)singleTap:(UIGestureRecognizer*)gestureRecognizer {
    NSLog(@"-----singleTap-----");
    SearchClassViewController *vc= [[SearchClassViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)doubleTap:(UIGestureRecognizer*)gestureRecognizer {
    NSLog(@"-----doubleTap-----");
    [self locateAgain];
}

//判断位置是否打开
- (void)judgeLocationWhetherOpen {

    // 判断是否打开GPS
    if ([CLLocationManager locationServicesEnabled] &&
        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways
         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
            //定位功能可用，开始定位
//            _mapView.showsUserLocation = YES;
        } else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        //NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"GPS未开启，无法添加位置" message:@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启思享者APP)" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *leftAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:leftAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)showAlterView {
    
    //初次安装
//    if (![TSAppInfo checkAppVersion]) {
    
        [[TSPublicTool shareInstance] creatActionAlterView:@"map_startAlter" size:CGSizeMake(ScreenWidth - 30, 100) action:^{
            NSLog(@"知道了");
            
        }];
        
        [[TSPublicTool shareInstance]showInView];

//    }

    
    
    
    
}


@end
