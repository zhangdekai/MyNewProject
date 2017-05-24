//
//  BasicViewController.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/16.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "BasicViewController.h"
#import "MBProgressHUD.h"

@interface BasicViewController ()<MBProgressHUDDelegate>

@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, copy) void (^emptyRetryBlock)();
@property (nonatomic, copy) void (^netWrokErrorRetryBlock)();
@property (nonatomic,copy) NavigationBarButtonItemBlock navigationItemBlock;
@property (nonatomic,copy) NavigationBarButtonItemBlockForRight rightItemBlock;

@end

@implementation BasicViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initView];
    [self initData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentSizeDidChangeNotification:) name:UIContentSizeCategoryDidChangeNotification object:nil];
}



- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addShadow {
    //1.设置阴影颜色
    
    self.navigationController.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;
    
    //2.设置阴影偏移范围
    
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(0, 2);
    
    //3.设置阴影颜色的透明度
    
    self.navigationController.navigationBar.layer.shadowOpacity = 0.2;
    
    //4.设置阴影半径
    
//    self.navigationController.navigationBar.layer.shadowRadius = 16;
    
    //5.设置阴影路径
    
    self.navigationController.navigationBar.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.navigationController.navigationBar.bounds].CGPath;
}

#pragma mark - public method
- (void)initView
{
//    [self useDefaultColor];
//    [self setBackBarButtonItem];
    
}

- (void)initData
{
    self.showErrorView = YES;
}




- (void)setNavigationBarTitle:(NSString *)title {
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.titleView = [TSPublicTool initWithTitle:title];

}

- (void)setNavigationBarBack {

    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(itemAction2)];
    
    self.navigationItem.leftBarButtonItem = rightBarItem;
    
    [self.navigationItem.leftBarButtonItem setImage:[[UIImage imageNamed:@"navigation_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}


- (void)setNavigationBarRightItemWithImageName:(NSString *)imageName itemBlock:(NavigationBarButtonItemBlockForRight)rightBlock {
    self.rightItemBlock = rightBlock;
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(itemAction1)];
    
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    [self.navigationItem.rightBarButtonItem setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
}

- (void)setNavigationBarLeftItemWithImageName:(NSString *)imageName itemBlock:(NavigationBarButtonItemBlock)leftBlock {
    self.navigationItemBlock = leftBlock;
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(itemAction)];
    
    self.navigationItem.leftBarButtonItem = rightBarItem;
    
    [self.navigationItem.leftBarButtonItem setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
}

- (void)itemAction {
    self.navigationItemBlock();
}

- (void)itemAction1 {
    self.rightItemBlock();
}

- (void)itemAction2 {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - private method
-(void)contentSizeDidChangeNotification:(NSNotification*)notification{
    [self contentSizeDidChange:notification.userInfo[UIContentSizeCategoryNewValueKey]];
}

#pragma mark - Implement in subclass
-(void)contentSizeDidChange:(NSString *)size{
    //Implement in subclass
}

#pragma mark - loading
- (void)showHud
{
    if (self.hud)
    {
        [self.hud removeFromSuperview];
        self.hud = nil;
    }
    
    self.hud = [[MBProgressHUD alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.hud];
    
    self.hud.delegate = self;
    [self.hud showAnimated:YES];
}

- (void)showHudWithText:(NSString *)text
{
    if (text.length == 0)
    {
        return;
    }
    
    if (self.hud)
    {
        [self.hud removeFromSuperview];
        self.hud = nil;
    }
    
    self.hud = [[MBProgressHUD alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.hud];
    
    self.hud.delegate = self;
    //self.hud.labelText = text;
    self.hud.label.text = text;

    [self.hud showAnimated:YES];
}

- (void)showHudWithTextOnly:(NSString *)text
{
    if (text.length == 0)
    {
        return;
    }
    
    if (self.hud)
    {
        [self.hud removeFromSuperview];
        self.hud = nil;
    }
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.delegate = self;
    self.hud.mode = MBProgressHUDModeText;
    self.hud.label.text = text;
    self.hud.label.textColor = [UIColor redColor];


    [self.hud hideAnimated:YES afterDelay:1.5];
//    [self.hud hide:YES afterDelay:1.5];
}

- (void)createHudWithContainView:(UIView *)aView
{
    self.hud = [[MBProgressHUD alloc] initWithFrame:aView.bounds];
    [aView addSubview:self.hud];
}

- (void)showHudInView:(UIView *)aView
{
    if (!aView)
    {
        return;
    }
    
    if (self.hud)
    {
        [self.hud removeFromSuperview];
        self.hud = nil;
    }
    
    [self createHudWithContainView:aView];
    self.hud.delegate = self;
    self.hud.mode = MBProgressHUDModeIndeterminate;
    
    [self.hud showAnimated:YES];
}

- (void)showHudWithText:(NSString *)text containView:(UIView *)aView
{
    if (!aView)
    {
        return;
    }
    
    if (self.hud)
    {
        [self.hud removeFromSuperview];
        self.hud = nil;
    }
    
    [self createHudWithContainView:aView];
    self.hud.label.text = text;
    self.hud.delegate = self;
    [self.hud showAnimated:YES];
}

- (void)showHudWithTextOnly:(NSString *)text containView:(UIView *)aView
{
    if (!aView || text.length == 0)
    {
        return;
    }
    
    if (self.hud)
    {
        [self.hud removeFromSuperview];
        self.hud = nil;
    }
    
    self.hud = [MBProgressHUD showHUDAddedTo:aView animated:YES];
    self.hud.delegate = self;
    self.hud.mode = MBProgressHUDModeText;
    self.hud.label.text = text;
    
    [self.hud hideAnimated:YES afterDelay:3];
}

- (void)hideHud
{
    [self.hud hideAnimated:YES];
}

- (void)hideHudAfterDelay:(NSTimeInterval) delay
{
    [self.hud hideAnimated:YES afterDelay:delay];
}

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    if (hud)
    {
        [hud removeFromSuperview];
        hud = nil;
    }
}

#pragma mark - 异常页面

- (void)showNoDataViewInView:(UIView *)containView
{
    [self showNoDataViewInView:containView lableAText:@"什么都没留下" lableBText:@"" lableCText:@"去看看其它伙伴们吧"];
}

- (void)showNoDataInSearchViewInView:(UIView *)containView aboutText:(NSString *)aboutText
{
    [self showNoDataViewInView:containView lableAText:@"抱歉咯" lableBText:[NSString stringWithFormat:@"没有搜索到相关%@信息", aboutText] lableCText:@"换个关键词搜搜看"];
}

- (void) showNoDataViewInView:(UIView *)containView lableAText:(NSString *)lableAString lableBText:(NSString *)lableBString lableCText:(NSString *)lableCString
{
    if (!containView)
    {
        return;
    }
    
    UIView *noDataViewOld = [containView viewWithTag:KNODATAVIEWTAG];
    if (noDataViewOld)
    {
        [noDataViewOld removeFromSuperview];
    }
    
    UIView *noDataView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(containView.frame), CGRectGetHeight(containView.frame))];
    noDataView.tag = KNODATAVIEWTAG;
    noDataView.backgroundColor = [UIColor ymh_colorWithHex:0xf4f4f4];
    NSString *imageName = nil;
    if ([lableBString isEqualToString:@""] || lableBString == nil) {
        imageName = [NSString stringWithFormat:@"noDatas"];
    } else {
        imageName = [NSString stringWithFormat:@"noResult"];
    }
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.centerX = containView.width / 2;
    imageView.centerY = 125 + imageView.height/2;
    [noDataView addSubview:imageView];
    
    UILabel *labelA = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.bottom + 20, CGRectGetWidth(containView.frame), 15)];
    labelA.text = lableAString;
    labelA.textColor = [UIColor ymh_colorWithHex:0x666666];
    labelA.font = [UIFont systemFontOfSize:15.0];
    [noDataView addSubview:labelA];
    labelA.textAlignment = NSTextAlignmentCenter;
    NSInteger maxH = labelA.bottom;
    
    if (![lableBString isEqualToString:@""] &&  lableBString != nil) {
        UILabel *labelB = [[UILabel alloc] initWithFrame:CGRectMake(0, labelA.bottom + 10, CGRectGetWidth(containView.frame), 15)];
        labelB.text = lableBString;
        labelB.textColor = [UIColor ymh_colorWithHex:0x666666];
        labelB.font = [UIFont systemFontOfSize:15.0];
        [noDataView addSubview:labelB];
        labelB.textAlignment = NSTextAlignmentCenter;
        maxH = labelB.bottom;
    }
    if (![lableCString isEqualToString:@""] &&  lableCString != nil) {
        UILabel *labelC = [[UILabel alloc] initWithFrame:CGRectMake(0, maxH + 10, CGRectGetWidth(containView.frame), 13)];
        labelC.text = lableCString;
        labelC.textColor = [UIColor ymh_colorWithHex:0x999999];
        labelC.font = [UIFont systemFontOfSize:13.0];
        [noDataView addSubview:labelC];
        
        labelC.textAlignment = NSTextAlignmentCenter;
    }
    [containView addSubview:noDataView];
}

-(void)removeNoDataViewInView:(UIView *)containView
{
    UIView *noDataView = [containView viewWithTag:KNODATAVIEWTAG];
    if (noDataView)
    {
        [noDataView removeFromSuperview];
    }
}

- (void)showErrorViewInView:(UIView *)containView retryBlcok:(void(^)())block;
{
    [self showErrorViewInView:containView errorType:KERRORVIEWTAG lableAText:@"哎呀，出错啦！" lableBText:@"数据加载失败，请点击重新加载" retryBlcok:block];
}
- (void)showErrorViewInView:(UIView *)containView
                 lableAText:(NSString *)lableAString
                 lableBText:(NSString *)lableBString
                 retryBlcok:(void(^)())block {
    [self showErrorViewInView:containView errorType:KNODATAVIEWTAG lableAText:lableAString lableBText:lableBString retryBlcok:block];
}

- (void)showErrorViewInView:(UIView *)containView
                  errorType:(NSInteger)errorType
                 lableAText:(NSString *)lableAString
                 lableBText:(NSString *)lableBString
                 retryBlcok:(void(^)())block
{
    if (!containView)
    {
        return;
    }
    
    self.emptyRetryBlock = block;
    
    UIView *errorViewOld = [containView viewWithTag:KERRORVIEWTAG];
    if (errorViewOld)
    {
        [errorViewOld removeFromSuperview];
    }
    
    
    UIView *errorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(containView.frame), CGRectGetHeight(containView.frame))];
    errorView.tag = KERRORVIEWTAG;
    errorView.backgroundColor = [UIColor ymh_colorWithHex:0xf4f4f4];
    
    NSString *imageName = nil;
    if (KERRORVIEWTAG == errorType) {
        imageName = @"noDisplay";
    } else {//if (KNONETWORKTAG == errorType){
        imageName = @"noNetwork";
    }
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.tag = 100;
    imageView.centerX = containView.width / 2;
    imageView.centerY = 125 + imageView.height/2;
    [errorView addSubview:imageView];
    
    UILabel *labelA = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.bottom + 15, CGRectGetWidth(containView.frame), 15)];
    labelA.text = lableAString;
    labelA.textColor = [UIColor ymh_colorWithHex:0x666666];
    labelA.font = [UIFont systemFontOfSize:15.0];
    [errorView addSubview:labelA];
    
    UILabel *labelB = [[UILabel alloc] initWithFrame:CGRectMake(0, labelA.bottom + 10, CGRectGetWidth(containView.frame), 12)];
    labelB.text = lableBString;
    labelB.textColor = [UIColor ymh_colorWithHex:0x999999];
    labelB.font = [UIFont systemFontOfSize:12.0];
    [errorView addSubview:labelB];
    
    labelA.textAlignment = labelB.textAlignment = NSTextAlignmentCenter;
    
    UIButton *retryButton = [[UIButton alloc] initWithFrame:CGRectMake(0, labelB.bottom + 15, 100, 33)];
    retryButton.centerX = labelA.centerX;
    [retryButton setTitle:@"重新加载" forState:UIControlStateNormal];
    [retryButton setTitleColor:[UIColor ymh_colorWithHex:0x666666] forState:UIControlStateNormal];
    [retryButton setTitleEdgeInsets:UIEdgeInsetsMake(10, 20, 10, 20)];
    retryButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [retryButton.layer setMasksToBounds:YES];
    [retryButton.layer setCornerRadius:3.0];
    retryButton.layer.borderColor = [UIColor ymh_colorWithHex:0x999999].CGColor;
    retryButton.layer.borderWidth = 0.5;
    [retryButton addTarget:self action:@selector(emptyRetryButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [errorView addSubview:retryButton];
    
    [containView addSubview:errorView];
}

-(void)removeErrorViewInView:(UIView *)containView
{
    UIView *noDataView = [containView viewWithTag:KERRORVIEWTAG];
    if (noDataView)
    {
        [noDataView removeFromSuperview];
    }
}

- (void)emptyRetryButtonAction:(id)sender
{
    if (self.emptyRetryBlock)
    {
        self.emptyRetryBlock();
    }
}

- (void)showNoNetworkViewInView:(UIView *)containView  retryBlcok:(void(^)())block;
{
    [self showErrorViewInView:containView errorType:KNONETWORKTAG lableAText:@"当前没有网络" lableBText:@"数据加载失败，请点击重新加载" retryBlcok:block];
    
}

-(void)removeNoNetWorkViewInView:(UIView *)containView
{
    UIView *noDataView = [containView viewWithTag:KERRORVIEWTAG];
    if (noDataView)
    {
        [noDataView removeFromSuperview];
    }
}

- (void)removeAllErrorViewInView:(UIView *)containView
{
    [self removeErrorViewInView:containView];
    [self removeNoDataViewInView:containView];
    [self removeNoNetWorkViewInView:containView];
}

- (void)showAlertWithMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end




