//
//  YMHRegularExpression.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/16.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMHRegularExpression : NSObject
/**
 *   验证手机号
 *
 */
+ (BOOL)validateMobile:(NSString *)mobileNum;
/**
 *   验证邮箱
 *
 */
+ (BOOL)validateEmail:(NSString *)email;
/**
 *   验证身份证
 *
 */
+ (BOOL)validateIdentityCard: (NSString *)identityCard;
/**
 *  用户姓名
 *
 */
+ (BOOL)validateName:(NSString *)name;
/**
 *   验证昵称
 *
 */
+ (BOOL)validateNickname:(NSString *)nickname;
/**
 *   验证密码
 *
 */
+ (BOOL)validatePassword:(NSString *)passWord;
/**
 *   验证用户名
 *
 */
+ (BOOL)validateUserName:(NSString *)name;
/**
 *  验证邮编
 *
 */
+ (BOOL)validatePostCode:(NSString *)postCode;
/**
 *   验证护照
 *
 */
+ (BOOL)validatePassport:(NSString *)passport;
/**
 *   验证军人证
 *
 */
+ (BOOL)validateSoldier:(NSString *)solderCode;
/**
 *   验证港澳通行证
 *
 */
+ (BOOL)validateHongKongMacau:(NSString *)HongKongMacauCode;
/**
 *  验证证件
 *
 *  @param certificateType 证件类型 - 身份证 - 护照 - 军人证 - 港澳通行证
 *  @param certificateNum  证件号码
 *
 *  @return 若为nil,验证通过；若非nil,return validateResultString
 */
+ (NSString *)validateCertificate:(NSString *)certificateType certificateNum:(NSString *)certificateNum;

@end
