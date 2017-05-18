//
//  YMHIdenCodeTool.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/16.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "YMHIdenCodeTool.h"
#import "YMHRegularExpression.h"
#import "BasicViewController.h"
#import "MBProgressHUD.h"

static YMHIdenCodeTool *instance = nil;

@interface YMHIdenCodeTool ()

@end

@implementation YMHIdenCodeTool

#pragma mark - 单例生成
+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //调用父类的alloc方法创建对象
        instance = [[super allocWithZone:nil] init];
    });
    return instance;
    
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    return [self sharedInstance];
    
}

//获取验证码
+ (void)idenCodeActionWithButton:(UIButton *)sender controller:(BasicViewController *)vc phoneNum:(NSString *)phoneNum {
    
    //验证手机号
    if (![YMHRegularExpression validateMobile:phoneNum]) {
        
        [vc showHudWithTextOnly:@"请输入正确的手机号"];
    }else {
        //请求验证码
//        [[YMHAccountDataCenter sharedInstance] requestSmsCodeWithPhoneNum:phoneNum success:^(STBaseRequest *request, STServerResponse *response) {
            //请求验证码成功
            //1.开启倒计时
            __block int timeout = 60; //倒计时时间
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
                        sender.backgroundColor = [UIColor greenColor];
                        sender.userInteractionEnabled = YES;
                    });
                }else{
                    int seconds = timeout % 61;
                    NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        //NSLog(@"____%@",strTime);
                        [UIView beginAnimations:nil context:nil];
                        [UIView setAnimationDuration:1];
                        [sender setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                        [UIView commitAnimations];
                        sender.userInteractionEnabled = NO;
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
            //2.提示...提示...已发送验证码
            [vc showHudWithTextOnly:@"已发送验证码"];
        
//        } failure:^(STBaseRequest *request, NSError *apiError) {
            //请求验证码失败...提示...发送验证码失败
//            if ((apiError.code == NSURLErrorNotConnectedToInternet)
//                || (apiError.code == NSURLErrorCannotConnectToHost)) {
//                [vc showHudWithTextOnly:@"请检查网络链接"];
//            }else {
//                [vc showHudWithTextOnly:@"获取验证码失败"];
//            }
//        }];
    }
    
}

@end
