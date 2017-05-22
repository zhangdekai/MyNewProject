//
//  AppDelegate.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/16.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TSAppInfo.h"
#import <MAMapKit/MAMapKit.h>


//#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor =  [UIColor whiteColor];
    
    LoginViewController *loginVc = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
    
    UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:loginVc];
    
    
//    //百度地图
//    BMKMapManager *manager = [[BMKMapManager alloc]init];
//    
//    BOOL ret =  [manager start:BaiDuMapKey generalDelegate:nil];
//    
//    if (!ret) {
//        NSLog(@"百度 manager start failed!");
//
//    }
    
    
    //高德地图
   // [AMapServices sharedServices].apiKey = AMapKey;
    
    
    //初次安装
    if ([TSAppInfo checkAppVersion]) {
        
    } else {//首次安装 添加导览
        
    }
    
    self.window.rootViewController = nv;

    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}


- (void)setRootViewController {
    
    if ([TSUserDefault objectForKey:@"isOne"])
    {//不是第一次安装

        
        //   self.window.rootViewController = self.viewController;
        
    }
    else
    {
        UIViewController *emptyView = [[ UIViewController alloc ]init ];
        self. window .rootViewController = emptyView;
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end