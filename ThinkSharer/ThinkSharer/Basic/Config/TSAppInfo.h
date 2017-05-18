//
//  TSAppInfo.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/16.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TSAppRegisterInfo;

@interface TSAppInfo : NSObject

+ (TSAppRegisterInfo *)registerAppInfo;  //app注册信息

+ (NSString *)appId;               //应用的appid
+ (NSString *)appShortVersion;     //app版本号
+ (NSString *)appVersion;          //app打包号
+ (NSString *)versionCode;          //与服务器交互时使用的版本代号
+ (NSString *)appName;             //app名称

+ (NSString *)appCurrentOSVersion;    //当前iOS版本

//+ (NSString *)userId;               //用户id
//+ (NSString *)userToken;            //userToken
//+ (NSString *)deviceId;             //设备id

+ (NSString *)channel;              //渠道

// 检查app 版本
+ (BOOL)checkAppVersion;



@end


/**
 *  用来组装设备注册信息
 */
@interface TSAppRegisterInfo : NSObject

@property (nonatomic, strong) NSString  *appId;
@property (nonatomic, strong) NSString  *versionCode;
@property (nonatomic, strong) NSString  *globalKeyChainAccessGroupName;
@property (nonatomic, strong) NSString  *customKeyChainAccessGroupName;
@property (nonatomic, assign) NSInteger smsContentTemplate;
@property (nonatomic, strong) NSURL     *agreementFileUrl;
@property (nonatomic, strong) NSString  *apiBaseUrl;
@property (nonatomic, strong) NSString  *userAgent;
@property (nonatomic, assign) BOOL      useHttpGzip;

@end
