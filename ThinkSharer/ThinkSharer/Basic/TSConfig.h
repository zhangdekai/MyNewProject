//
//  TSConfig.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/16.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#ifndef TSConfig_h
#define TSConfig_h

//屏幕宽高
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

// NSNotificationCenter
#define TSNotificationCenter [NSNotificationCenter defaultCenter]
// NSUserDefaults
#define TSUserDefault [NSUserDefaults standardUserDefaults]

//高德地图appkey
#define AMapKey @"60cdaf0e3e58dbd9c1f74a24a14899bd"

//百度地图appkey
#define BaiDuMapKey @"SHGZjSp2DEK7S7GmtPsSvdvw7uxnTopq"

#define  TSWeakSelf __weak typeof(self)weakSelf = self;



#endif /* TSConfig_h */
