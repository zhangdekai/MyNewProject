//
//  YMHRegularExpression.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/16.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "YMHRegularExpression.h"

@implementation YMHRegularExpression

+ (BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,152,157,158,159,178,182,183,184,187,188
     
     * 联通：130,131,132,145,152,155,156,176,185,186
     
     * 电信：133,1349,153,177,180,181,189
     
     * 虚拟运营商：170
     
     */
    NSString * MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[06-8]|8[0-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,152,157,158,159,178,182,183,184,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|47|5[0-27-9]|78|8[2-478])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,145,152,155,156,176,185,186
     17         */
    
    NSString * CU = @"^1(3[0-2]|45|5[256]|76|8[56])\\d{8}$";
    
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,177,180,181,189
     22         */
    NSString * CT = @"^1((33|53|77|8[019])[0-9]|349)\\d{7}$";
    /**
     15         * 虚拟运营商：
     16         * 170
     17         */
    NSString * CF = @"^1(70)\\d{8}$";
    /**
     15         * 虚拟运营商：
     16         * 160
     17         */
    NSString * CN = @"^1(60)\\d{8}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    //怡美要求1开头，11位数字即可
    NSString * CYMH = @"^1\\d{10}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestcf = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CF];
    NSPredicate *regextestcn = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CN];
    //怡美要求1开头，11位数字即可
    NSPredicate *regextestcymh = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CYMH];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)
        || ([regextestcf evaluateWithObject:mobileNum] == YES)
        || ([regextestcn evaluateWithObject:mobileNum] == YES)
        || ([regextestcymh evaluateWithObject:mobileNum] == YES))//怡美要求1开头，11位数字即可
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
//身份证
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X|x)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
//姓名
+ (BOOL)validateName:(NSString *)name
{
    //怡美假日姓名
    //NSString *userNameRegex = @"^[\u4E00-\u9FA5]{2,}+$|^[a-zA-Z]{2,}+$";//仅两个以上汉字或仅三个以上英文
    NSString *userNameRegex = @"^[\u4E00-\u9FA5A-Za-z]{2,}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    return [userNamePredicate evaluateWithObject:name];
}
//昵称
+ (BOOL) validateNickname:(NSString *)nickname
{
    //怡美假日昵称
    NSString *nicknameRegex = @"^[\u4E00-\u9FA5A-Za-z0-9_]{2,}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}
//密码
+ (BOOL) validatePassword:(NSString *)passWord
{
    //怡美假日密码,6到16位数字字母,同时包含
    NSString *passWordRegex = @"^(?![^a-zA-Z]+$)(?!\\D+$)[[A-Za-z][0-9]]{6,16}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}
//用户名
+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}
//中国邮编
+ (BOOL)validatePostCode:(NSString *)postCode {
    NSString *postCodeRegex = @"^[0-9]\\d{5}(?!\\d)$";
    NSPredicate *postCodePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",postCodeRegex];
    return [postCodePredicate evaluateWithObject:postCode];
}
//护照
+ (BOOL)validatePassport:(NSString *)passport
{
    NSString *passportRegex = @"(^(G|g)\\d{8}$)|(^(E|e)\\d{8}$)";
    NSPredicate *passportPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passportRegex];
    return [passportPredicate evaluateWithObject:passport];
}
//军人证
+ (BOOL)validateSoldier:(NSString *)soldierCode
{
    NSString *soldierCodeRegex = @"^[\u4e00-\u9fa5a-zA-Z0-9]{0,20}$";
    NSPredicate *soldierCodePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",soldierCodeRegex];
    return [soldierCodePredicate  evaluateWithObject:soldierCode];
    
}
//港澳通行证
+ (BOOL)validateHongKongMacau:(NSString *)HongKongMacauCode
{
    NSString *HongKongMacauCodeRegex = @"(^(W|w)\\d{8}$)|(^(C|c)\\d{8}$)";
    NSPredicate *HongKongMacauCodePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",HongKongMacauCodeRegex];
    return [HongKongMacauCodePredicate evaluateWithObject:HongKongMacauCode];
}
/**
 *  验证证件
 *
 *  @param certificateType 证件类型 - 身份证 - 护照 - 军人证 - 港澳通行证
 *  @param certificateNum  证件号码
 *
 *  @return 若为nil,验证通过；若非nil,return validateResultString
 */
+ (NSString *)validateCertificate:(NSString *)certificateType certificateNum:(NSString *)certificateNum {
    NSString *validateResultString;
    //身份证
    if ([certificateType isEqualToString:@"身份证"]) {
        if (![YMHRegularExpression validateIdentityCard:certificateNum]) {
            validateResultString = @"请输入合法身份证号";
        }else {
            validateResultString = nil;
        }
    }else if ([certificateType isEqualToString:@"军人证"]) {
        if (![YMHRegularExpression validateSoldier:certificateNum]) {
            validateResultString = @"请输入合法军人证号";
        }else {
            validateResultString = nil;
        }
    }else if ([certificateType isEqualToString:@"护照"]) {
        if (![YMHRegularExpression validatePassport:certificateNum]) {
            validateResultString = @"请输入合法护照号";
        }else {
            validateResultString = nil;
        }
    }else if ([certificateType isEqualToString:@"港澳通行证"]) {
        if (![YMHRegularExpression validateHongKongMacau:certificateNum]) {
            validateResultString = @"请输入合法港澳通行证号";
        }else {
            validateResultString = nil;
        }
    }
    return validateResultString;
}
@end
