//
//  TSAppInfo.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/16.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "TSAppInfo.h"
#import "TSAccountManager.h"

@implementation TSAppInfo

static NSString *const APPID = @"2";
//static NSUInteger SMSContentTemplateID = 1;


+ (TSAppRegisterInfo *)registerAppInfo
{
    NSString *entitlementsPath = [[NSBundle mainBundle] pathForResource:@"YimayHoliday" ofType:@"entitlements"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:entitlementsPath];
    NSArray *keyChainAccessGroupNameArray = (NSArray*)[data objectForKey:@"keychain-access-groups"];
    
    NSString *globalKeyChainAccessGroupName = @"";
    NSString *customKeyChainAccessGroupName = @"";
    if (keyChainAccessGroupNameArray.count > 0) {
        globalKeyChainAccessGroupName = [keyChainAccessGroupNameArray objectAtIndex:0];
        customKeyChainAccessGroupName = [keyChainAccessGroupNameArray objectAtIndex:1];
    }
    
    TSAppRegisterInfo *registerInfo = [[TSAppRegisterInfo alloc] init];
    registerInfo.appId = APPID;
    registerInfo.versionCode = [TSAppInfo versionCode];
    registerInfo.globalKeyChainAccessGroupName = globalKeyChainAccessGroupName;
    registerInfo.customKeyChainAccessGroupName = customKeyChainAccessGroupName;
    
//    registerInfo.smsContentTemplate = SMSContentTemplateID;
//    registerInfo.agreementFileUrl = [NSURL URLWithString:@""];
//    registerInfo.apiBaseUrl = YMAPI_BaseUrl;
//    registerInfo.userAgent = YMAPI_UserAgent;
//    registerInfo.useHttpGzip = @YMAPI_UseHttpGzip;
    
    return registerInfo;
}

+ (NSString *)appId
{
    return APPID;
}

+ (NSString *)appVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

+ (BOOL)checkAppVersion
{
    //设置版本号key
    NSString *versionKey = @"CFBundleVersion";
    //取得沙盒中上次存储的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:versionKey];
    //取得当前软件的版本号
    NSString *bundleVersion = [self appVersion];
    if ([bundleVersion isEqualToString:lastVersion]) {
        return YES;
    } else {
        [defaults setValue:bundleVersion forKey:versionKey];
        [defaults synchronize];
        return NO;
    }
}

+ (NSString *)versionCode
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"VersionCode"];
}

+ (NSString *)appShortVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)appCurrentOSVersion
{
    return [UIDevice currentDevice].systemVersion;
}

//+ (NSString *)userId
//{
//    long long userID = [TSAccountManager shareInstance].accountContext.userId;
//    return  @(userID).stringValue;
//}
//
//+ (NSString *)userToken
//{
//    return [YMHAccountManager shareInstance].accountContext.token;
//    return nil;
//}
//
//+ (NSString *)deviceId
//{
//    return [YMHAccountManager shareInstance].accountContext.deviceId;
//    return nil;
//}

+ (NSString *)channel
{
    NSString *channelID = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"YMHChannelID"];
    if (channelID.length > 0)
    {
        return channelID;
    }
    
    return @"";
}


@end


@implementation TSAppRegisterInfo


@end
