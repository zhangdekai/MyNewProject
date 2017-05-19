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
#import "TSCustomTextFiled.h"


@interface LoginViewController ()<UITextFieldDelegate>


//@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (strong, nonatomic)  TSCustomTextFiled *phoneTextFiled;
@property (strong, nonatomic)  TSCustomTextFiled *identityTextFiled;

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
    CGFloat rheight = [TSPublicTool getRealPX:255];
    CGFloat textHeight = [TSPublicTool getRealPX:50];
    CGFloat textWidth = ScreenWidth - 30;
    CGFloat identityW = [TSPublicTool getRealPX:195];
    CGFloat getIdentityW = [TSPublicTool getRealPX:120];
    
    _phoneBackView.frame = CGRectMake(15, rheight, textWidth, textHeight);
    _phoneBackView.layer.cornerRadius = 5;
    _phoneBackView.layer.borderWidth = 0.1;
    _phoneBackView.layer.borderColor = [UIColor generalSubTitleFontGrayColor].CGColor;
    
    [[_phoneBackView layer]setShadowOffset:(CGSizeMake(0, 2))];
    [[_phoneBackView layer]setShadowRadius:2];
    [[_phoneBackView layer]setShadowOpacity:0.3];
    [[_phoneBackView layer]setShadowColor:[UIColor viewShaowColor].CGColor];
    
    
    _phoneTextFiled = [[TSCustomTextFiled alloc]initWithFrame:CGRectMake(25, 0, _phoneBackView.width - 25, textHeight)];
    _phoneTextFiled.textColor = [UIColor generalTitleFontGrayColor];
    _phoneTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneTextFiled.placeholder = @"请输入手机号";
    _phoneTextFiled.font = [UIFont systemFontOfSize:17];
//    [_phoneTextFiled setValue:[UIFont systemFontOfSize:17] forKeyPath:@"_placeholderLabel.font"];
    
    [_phoneBackView addSubview:_phoneTextFiled];
    
    
    _identityBackView.frame = CGRectMake(15, _phoneBackView.bottom + 30, identityW, textHeight);
    _identityBackView.layer.cornerRadius = 5;
    _identityBackView.layer.borderWidth = 0.1;
    _identityBackView.layer.borderColor = [UIColor generalSubTitleFontGrayColor].CGColor;

    
    [[_identityBackView layer]setShadowOffset:(CGSizeMake(0, 2))];
    [[_identityBackView layer]setShadowRadius:2];
    [[_identityBackView layer]setShadowOpacity:0.3];
    [[_identityBackView layer]setShadowColor:[UIColor viewShaowColor].CGColor];

    
    
    
    _identityTextFiled = [[TSCustomTextFiled alloc]initWithFrame:CGRectMake(25, 0, _identityBackView.width - 25, textHeight)];
    _identityTextFiled.textColor = [UIColor generalSubTitleFontGrayColor];

    _identityTextFiled.MaxNum = 6;
    _identityTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    _identityTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _identityTextFiled.placeholder = @"请输入验证码";
    _identityTextFiled.font = [UIFont systemFontOfSize:14];
//    [_identityTextFiled setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    
    [_identityBackView addSubview:_identityTextFiled];


    _getIdentityButton.frame = CGRectMake(_identityBackView.right + 30, _identityBackView.top, getIdentityW, textHeight);
    
    _getIdentityButton.layer.cornerRadius = 5;
    _getIdentityButton.layer.borderWidth = 0.1;
    _getIdentityButton.layer.borderColor = [UIColor generalSubTitleFontGrayColor].CGColor;

    
    [[_getIdentityButton layer]setShadowOffset:(CGSizeMake(0, 2))];
    [[_getIdentityButton layer]setShadowRadius:2];
    [[_getIdentityButton layer]setShadowOpacity:0.3];
    [[_getIdentityButton layer]setShadowColor:[UIColor viewShaowColor].CGColor];


    _rightOrWrongButton.frame = CGRectMake(20, _identityBackView.bottom + 30, 15, 15);

    _userGuideButton.frame = CGRectMake(_rightOrWrongButton.right + 5, _rightOrWrongButton.top - 5 , ScreenWidth - 120, 25);

    _loginButton.frame = CGRectMake(15, _userGuideButton.bottom + 30, ScreenWidth - 30, textHeight);
    
    [[_loginButton layer]setShadowOffset:(CGSizeMake(0, 2))];
    [[_loginButton layer]setShadowRadius:2];
    [[_loginButton layer]setShadowOpacity:0.3];
    [[_loginButton layer]setShadowColor:[UIColor viewShaowColor].CGColor];


    [_getIdentityButton addTarget:self action:@selector(getIdentity:) forControlEvents:(UIControlEventTouchUpInside)];

    [_loginButton addTarget:self action:@selector(login:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [_rightOrWrongButton addTarget:self action:@selector(selectUserGuide:) forControlEvents:(UIControlEventTouchUpInside)];


    UIImageView *backgroundImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_background"]];
    backgroundImage.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [self.view addSubview:backgroundImage];
    
    [self.view sendSubviewToBack:backgroundImage];
    
    
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
