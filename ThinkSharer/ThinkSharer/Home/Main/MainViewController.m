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

@interface MainViewController ()<MAMapViewDelegate>

@property (nonatomic,strong) MAMapView *mapView;
@property (nonatomic,strong) CLLocationManager *locationManager;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //    定位授权
    
    _locationManager = [[CLLocationManager alloc]init];
    [_locationManager requestWhenInUseAuthorization];

    
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    
    ///初始化地图
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.showsCompass = NO;
    self.mapView.delegate = self;
    ///把地图添加至view
    [self.view addSubview:self.mapView];
    
    //创建坐标
    CLLocationCoordinate2D coor ;
    coor.latitude = 39.33232132323;
    coor.longitude = 116.23423423423;
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    
    pointAnnotation.coordinate = coor;
    
    
    //创建坐标
    CLLocationCoordinate2D coor1 ;
    coor1.latitude = 38.332321323;
    coor1.longitude = 116.23423423423;
    
    MAPointAnnotation *pointAnnotation1 = [[MAPointAnnotation alloc] init];
    
    pointAnnotation1.coordinate = coor1;
    
    //创建坐标
    CLLocationCoordinate2D coor2 ;
    coor2.latitude = 37.3323213;
    coor2.longitude = 116.23423423423;
    
    MAPointAnnotation *pointAnnotation2 = [[MAPointAnnotation alloc] init];
    
    pointAnnotation2.coordinate = coor2;

    
    //设置地图的定位中心点坐标
    self.mapView.centerCoordinate = coor;
    //将点添加到地图上，即所谓的大头针
    [self.mapView addAnnotation:pointAnnotation];
    [self.mapView addAnnotation:pointAnnotation1];
    [self.mapView addAnnotation:pointAnnotation2];

    
    //添加开始
    UIImageView *startImage = [[UIImageView alloc]init];
    [self.view addSubview:startImage];
    
   
    
    
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    
    MAAnnotationView *customView = [[MAAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"customView"];
    
    UILabel *lanbel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    lanbel.text = @"纳斯卡";
    [customView addSubview:lanbel];
    
    customView.image = [UIImage imageNamed:@"map_boy"];

    
    return customView;

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
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
