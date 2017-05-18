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
    
    
    self.mapView.showsUserLocation = YES;
    [self.mapView setUserTrackingMode:(MAUserTrackingModeFollow) animated:YES];

    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5/*延迟执行时间*/ * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        
        self.mapView.userTrackingMode = MAUserTrackingModeFollow;

    });

    
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self stopSerialLocation];
}

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

        customView.size = CGSizeMake(37, 37);
        UILabel *lanbel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
        lanbel.text = @"思";
        lanbel.textAlignment = NSTextAlignmentCenter;
        [customView addSubview:lanbel];

        customView.image = [UIImage imageNamed:@"map_boy"];

    }
    
}



- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    
    NSLog(@"didSelectAnnotationView");
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)addStartImage {
    //添加开始
    UIImageView *startImage = [[UIImageView alloc]init];
    [self.view addSubview:startImage];
    startImage.frame = CGRectMake((ScreenWidth /2) - 30, ScreenHeight - 85, 60, 60);
    
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
    rightImage.frame = CGRectMake(ScreenWidth - 30 , 100, 40, 40);
    
    rightImage.image = [UIImage imageNamed:@"map_go"];
    rightImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goRight)];
    [rightImage addGestureRecognizer:tap];
}

- (void)goRight {
    
}

- (void)singleTap:(UIGestureRecognizer*)gestureRecognizer {
    NSLog(@"-----singleTap-----");
    
}

- (void)doubleTap:(UIGestureRecognizer*)gestureRecognizer {
    NSLog(@"-----doubleTap-----");
    [self locateAgain];
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


- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    //    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
}

- (void)startSerialLocation
{
    //开始定位
    //    [self.locationManager startUpdatingLocation];
    
    [self.locationManager setLocatingWithReGeocode:YES];
    [self.locationManager startUpdatingLocation];
}

- (void)stopSerialLocation
{
    //停止定位
    [self.locationManager stopUpdatingLocation];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    //定位错误
    NSLog(@"定位错误  %s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    //定位结果
    NSLog(@"定位结果 location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
}




- (void)getCurrentLocationData {
    //定位
    _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    _mapView.delegate = self;
    // 判断是否打开GPS
    if ([CLLocationManager locationServicesEnabled] &&
        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways
         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
            //定位功能可用，开始定位
            _mapView.showsUserLocation = YES;
        }
    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        //NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"GPS未开启，无法添加位置" message:@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启怡美假日APP)" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *leftAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:leftAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = 0;
    [self.view addSubview:_mapView];
}



@end
