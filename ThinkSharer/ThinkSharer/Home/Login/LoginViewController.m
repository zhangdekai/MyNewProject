//
//  LoginViewController.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/16.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "LoginViewController.h"
#import "YMHIdenCodeTool.h"
#import "SelectClassViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *identityTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *getIdentityButton;

@property (weak, nonatomic) IBOutlet UIButton *rightOrWrongButton;

@property (weak, nonatomic) IBOutlet UIButton *userGuideButton;

@property (weak, nonatomic) IBOutlet UIView *phoneBackView;
@property (weak, nonatomic) IBOutlet UIView *identityBackView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (nonatomic,assign) BOOL selectUserGuide;

@end

@implementation LoginViewController

#pragma mark life style
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor ymh_colorWithHex:0xfcfcfc];
    
    [self initilizeUI];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)initilizeUI {
    self.selectUserGuide = NO;
    CGFloat rheight = [TSPublicTool getRealPX:270];
    CGFloat textHeight = [TSPublicTool getRealPX:40];
    CGFloat textWidth = ScreenWidth - 30;
    CGFloat identityW = [TSPublicTool getRealPX:195];
    CGFloat getIdentityW = [TSPublicTool getRealPX:120];

    
    _headerImageView.frame = CGRectMake(0, 0, ScreenWidth, rheight);
    
    
    _phoneBackView.frame = CGRectMake(15, rheight, textWidth, textHeight);
    _phoneBackView.layer.cornerRadius = 5;
    _phoneBackView.layer.borderWidth = 0.1;
    _phoneBackView.layer.borderColor = [UIColor generalSubTitleFontGrayColor].CGColor;
    
    _phoneTextFiled.frame = CGRectMake(25, 5, _phoneBackView.width - 25, 30);

    
    _identityBackView.frame = CGRectMake(15, _phoneBackView.bottom + 30, identityW, textHeight);
    _identityBackView.layer.cornerRadius = 5;
    _identityBackView.layer.borderWidth = 0.1;
    _identityBackView.layer.borderColor = [UIColor generalSubTitleFontGrayColor].CGColor;

    _identityTextFiled.frame = CGRectMake(25, 5, _identityBackView.width - 25, 30);


    _getIdentityButton.frame = CGRectMake(_identityBackView.right + 30, _identityBackView.top, getIdentityW, textHeight);

    _rightOrWrongButton.frame = CGRectMake(20, _identityBackView.bottom + 30, 15, 15);

    _userGuideButton.frame = CGRectMake(_rightOrWrongButton.right + 5, _rightOrWrongButton.top - 5 , ScreenWidth - 60, 25);

    _loginButton.frame = CGRectMake(15, _userGuideButton.bottom + 30, ScreenWidth - 30, textHeight);

    [_getIdentityButton addTarget:self action:@selector(getIdentity:) forControlEvents:(UIControlEventTouchUpInside)];

    [_loginButton addTarget:self action:@selector(login:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [_rightOrWrongButton addTarget:self action:@selector(selectUserGuide:) forControlEvents:(UIControlEventTouchUpInside)];


}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_phoneTextFiled resignFirstResponder];
    [_identityTextFiled resignFirstResponder];
}

#pragma mark Actions
//获取验证码
- (void )getIdentity:(UIButton *)button {
    
    [YMHIdenCodeTool idenCodeActionWithButton:button controller:self phoneNum:_phoneTextFiled.text];
    
}

- (void)selectUserGuide:(UIButton *)button {
    if (self.selectUserGuide) {
        [button setBackgroundImage:[UIImage imageNamed:@"login-selected"] forState:(UIControlStateNormal)];

    } else {
        [button setBackgroundImage:[UIImage imageNamed:@"login-pre"] forState:(UIControlStateNormal)];

    }

    self.selectUserGuide = !self.selectUserGuide;

}

//登录
- (void)login:(UIButton *)sender {
    
    SelectClassViewController *vc = [[SelectClassViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
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
