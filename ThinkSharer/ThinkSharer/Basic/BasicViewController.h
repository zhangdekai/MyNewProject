//
//  BasicViewController.h
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/16.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KNODATAVIEWTAG -10000
#define KERRORVIEWTAG -10001
#define KNONETWORKTAG -10002

typedef void(^NavigationBarButtonItemBlock)();
typedef void(^NavigationBarButtonItemBlockForRight)();


@interface BasicViewController : UIViewController


//设置导航栏title
- (void)setNavigationBarTitle:(NSString *)title;

//设置导航栏默认返回箭头
- (void)setNavigationBarBack;

//设置导航栏右侧image
- (void)setNavigationBarRightItemWithImageName:(NSString *)imageName itemBlock:(NavigationBarButtonItemBlockForRight)rightBlock ;

//设置导航栏左侧image
- (void)setNavigationBarLeftItemWithImageName:(NSString *)imageName itemBlock:(NavigationBarButtonItemBlock)leftBlock ;

//给导航条家阴影，去掉阴影
- (void)addShadow ;
- (void)hiddenShadow ;


/**
 *  是否展示相关错误页面  需求：展示本地数据时不展示错误页
 */
@property (assign, nonatomic) BOOL showErrorView;

/**
 *  相关View初始化
 */
- (void)initView;

/**
 *  相关data初始化
 */
- (void)initData;

/**
 *  显示loading(hud加到self.view上)
 */
- (void)showHud;

/**
 *  显示loading(菊花&文字 hud加到self.view上)
 *
 *  @param text  文本内容
 */
- (void)showHudWithText:(NSString *)text;

/**
 *  显示loading(只有文字 hud加到self.view上)
 *
 *  @param text  文本内容
 */
- (void)showHudWithTextOnly:(NSString *)text;

/**
 *  显示loading(只有菊花)
 *
 *  @param aView 父view
 */
- (void)showHudInView:(UIView *)aView;

/**
 *  显示loading(菊花&文字)
 *
 *  @param text  文本内容
 *  @param aView 父View
 */
- (void)showHudWithText:(NSString *)text containView:(UIView *)aView;

/**
 *  显示loading(只有文字)
 *
 *  @param text  文本内容
 *  @param aView 父View
 */
- (void)showHudWithTextOnly:(NSString *)text containView:(UIView *)aView;

/**
 *  结束loadingView
 */
- (void)hideHud;

- (void)hideHudAfterDelay:(NSTimeInterval) delay;

/**
 *  contentSizeDidChange
 *
 *  @param size size
 */
-(void)contentSizeDidChange:(NSString*)size;

/**
 *  添加空数据View
 *
 *  @param containView 父View
 */
- (void)showNoDataViewInView:(UIView *)containView;

/**
 *  添加异常页面
 *
 *  @param containView  容器View
 *  @param lableAString 头部文字
 *  @param lableBString 底部文字
 *  @param block 刷新回调
 */
- (void)showErrorViewInView:(UIView *)containView
                 lableAText:(NSString *)lableAString
                 lableBText:(NSString *)lableBString
                 retryBlcok:(void(^)())block;

/**
 *  移除空数据View
 *
 *  @param containView 父View
 */
-(void)removeNoDataViewInView:(UIView *)containView;

/**
 *  添加错误View
 *
 *  @param containView 父View
 *  @param block       retry block
 */
- (void)showErrorViewInView:(UIView *)containView retryBlcok:(void(^)())block;

/**
 *  移除错误View
 *
 *  @param containView 父View
 */
-(void)removeErrorViewInView:(UIView *)containView;

/**
 *  添加无网络View
 *
 *  @param containView 父View
 *  @param block       retry block
 */
- (void)showNoNetworkViewInView:(UIView *)containView  retryBlcok:(void(^)())block;

/**
 *  移除无网络View
 *
 *  @param containView 父View
 */
-(void)removeNoNetWorkViewInView:(UIView *)containView;

/**
 *  移除所有异常View
 *
 *  @param containView 父View
 */
- (void)removeAllErrorViewInView:(UIView *)containView;
/**
 *  展示提示信息
 *
 *  @param message 提示信息
 */
- (void)showAlertWithMessage:(NSString *)message;

/**
 *  添加空数据View
 *
 *  @param containView  父View
 *  @param lableAString 主标题
 *  @param lableBString 副标题
 */
- (void) showNoDataViewInView:(UIView *)containView lableAText:(NSString *)lableAString lableBText:(NSString *)lableBString lableCText:(NSString *)lableCString;

- (void)showNoDataInSearchViewInView:(UIView *)containView aboutText:(NSString *)aboutText;

@end
