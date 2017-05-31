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
#import "UserGuideViewController.h"
#import "LoactionIdentityView.h"


@interface LoginViewController ()<UITextFieldDelegate>


//@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (strong, nonatomic)  TSCustomTextFiled *phoneTextFiled;
@property (strong, nonatomic)  TSCustomTextFiled *identityTextFiled;
@property (strong, nonatomic)  TSCustomTextFiled *locateCodeTextFiled;

@property (weak, nonatomic) IBOutlet UIButton *getIdentityButton;

@property (weak, nonatomic) IBOutlet UIButton *rightOrWrongButton;

@property (weak, nonatomic) IBOutlet UIButton *userGuideButton;

@property (weak, nonatomic) IBOutlet UIView *phoneBackView;
@property (weak, nonatomic) IBOutlet UIView *identityBackView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (nonatomic,strong) LoactionIdentityView *authCodeView;

@property (nonatomic,strong) UIView *dynamicView;



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
    
    CGFloat rheight = [TSPublicTool getRealPX:230];
    CGFloat textHeight = [TSPublicTool getRealPX:44];
    CGFloat textWidth = ScreenWidth - 30;
    CGFloat identityW = [TSPublicTool getRealPX:195];
    CGFloat getIdentityW = [TSPublicTool getRealPX:120];
    
    _phoneBackView.frame = CGRectMake(15, rheight, textWidth, textHeight);

    [_phoneBackView addCornerRadius:5];
    
//    [_phoneBackView addShadow];
    
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 15, 15)];
    icon.center = CGPointMake(22.5, textHeight / 2);
    icon.image = [UIImage imageNamed:@"login_phone"];
    [_phoneBackView addSubview:icon];
    
    
    
    _phoneTextFiled = [[TSCustomTextFiled alloc]initWithFrame:CGRectMake(icon.right + 10, 0, _phoneBackView.width - 50, textHeight)];
    _phoneTextFiled.delegate = self;
    _phoneTextFiled.textColor = [UIColor generalTitleFontGrayColor];
    _phoneTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneTextFiled.placeholder = @"请输入手机号";
    _phoneTextFiled.font = [UIFont systemFontOfSize:17];
//    [_phoneTextFiled setValue:[UIFont systemFontOfSize:17] forKeyPath:@"_placeholderLabel.font"];
    
    [_phoneBackView addSubview:_phoneTextFiled];
    
    
    _identityBackView.frame = CGRectMake(15, _phoneBackView.bottom + 15, identityW, textHeight);
    [_identityBackView addCornerRadius:5];
    
    
    UIImageView *icon1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 13, 15, 15)];
    icon1.center = CGPointMake(22.5, textHeight / 2);
    icon1.image = [UIImage imageNamed:@"login_code"];
    [_identityBackView addSubview:icon1];

    _identityTextFiled = [[TSCustomTextFiled alloc]initWithFrame:CGRectMake(icon1.right + 10, 0, _identityBackView.width - 50, textHeight)];
    _identityTextFiled.textColor = [UIColor generalSubTitleFontGrayColor];

    _identityTextFiled.delegate = self;

    _identityTextFiled.MaxNum = 6;
    _identityTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    _identityTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _identityTextFiled.placeholder = @"验证码";
    _identityTextFiled.font = [UIFont systemFontOfSize:15];
//    [_identityTextFiled setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    
    [_identityBackView addSubview:_identityTextFiled];
    
    
    
    //显示验证码界面
    _authCodeView = [[LoactionIdentityView alloc] initWithFrame:CGRectMake(_identityBackView.right + 15, _identityBackView.top, 120, 44)];
    [self.view addSubview:_authCodeView];
//    [_authCodeView addCornerRadius:5];
    
    _identityBackView.hidden = YES;
    _authCodeView.hidden = YES;

    
    //动态码
    
    
    _dynamicView = [[UIView alloc]initWithFrame:CGRectMake(15, _phoneBackView.bottom + 15, identityW, textHeight)];
    [self.view addSubview:_dynamicView];
    _dynamicView.backgroundColor = [UIColor whiteColor];
    [_dynamicView addCornerRadius:5];
    
    UIImageView *icon2 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 13, 15, 15)];
    icon2.center = CGPointMake(22.5, textHeight / 2);
    icon2.image = [UIImage imageNamed:@"login_code2"];
    [_dynamicView addSubview:icon2];

    
    _locateCodeTextFiled = [[TSCustomTextFiled alloc]initWithFrame:CGRectMake(icon.right + 10, 0, _dynamicView.width - 50, textHeight)];
    _locateCodeTextFiled.delegate = self;
    _locateCodeTextFiled.MaxNum = 6;

    _locateCodeTextFiled.textColor = [UIColor generalSubTitleFontGrayColor];
    _locateCodeTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    _locateCodeTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _locateCodeTextFiled.placeholder = @"动态码";
    _locateCodeTextFiled.font = [UIFont systemFontOfSize:17];
    
    [_dynamicView addSubview:_locateCodeTextFiled];


    _getIdentityButton.frame = CGRectMake(_dynamicView.right + 15, _dynamicView.top , getIdentityW, textHeight);
    _getIdentityButton.layer.cornerRadius = 5;
    _getIdentityButton.layer.borderColor = [UIColor generalSubTitleFontGrayColor].CGColor;

    _getIdentityButton.enabled = NO;


    _userGuideButton.frame = CGRectMake(15, _getIdentityButton.bottom +25 , ScreenWidth - 30, 18);

   
    _loginButton.frame = CGRectMake(15, _userGuideButton.bottom + 30, ScreenWidth - 30, textHeight);
    [_loginButton addCornerRadius:5];

    
    
    
    //
    
    
    
    

    [_getIdentityButton addTarget:self action:@selector(getIdentity:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [_userGuideButton addTarget:self action:@selector(userGuide:) forControlEvents:(UIControlEventTouchUpInside)];


    [_loginButton addTarget:self action:@selector(login:) forControlEvents:(UIControlEventTouchUpInside)];
    


    UIImageView *backgroundImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_background"]];
    backgroundImage.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [self.view addSubview:backgroundImage];
    
    [self.view sendSubviewToBack:backgroundImage];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)changeUI {
    
    _identityBackView.hidden = NO;
    _authCodeView.hidden = NO;


    CGFloat textHeight = [TSPublicTool getRealPX:44];
    CGFloat identityW = [TSPublicTool getRealPX:195];
    CGFloat getIdentityW = [TSPublicTool getRealPX:120];

    _dynamicView.frame =CGRectMake(15, _identityBackView.bottom + 15, identityW, textHeight);
    
    _getIdentityButton.frame = CGRectMake(_dynamicView.right + 15, _dynamicView.top , getIdentityW, textHeight);

    _userGuideButton.frame = CGRectMake(40, _getIdentityButton.bottom +25 , ScreenWidth - 80, 18);
    
    _loginButton.frame = CGRectMake(15, _userGuideButton.bottom + 30, ScreenWidth - 30, textHeight);
    
    
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == _phoneTextFiled) {
        
        NSString *new = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if(new.length >= 11){
            
            [self changeUI];
        }

    } else if (textField == _identityTextFiled) {
        
        NSString *new = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if(new.length >= 6){
            
            _getIdentityButton.enabled = YES;
            _getIdentityButton.backgroundColor = [UIColor mainColorBlue];
            
        }
    }
    
    return YES;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == _phoneTextFiled) {
        _phoneBackView.layer.borderColor = [UIColor mainColorBlue].CGColor;
        _identityBackView.layer.borderColor = [UIColor generalSubTitleFontGrayColor].CGColor;
        _dynamicView.layer.borderColor = [UIColor generalSubTitleFontGrayColor].CGColor;
        
    } else if (textField == _identityTextFiled) {
        _phoneBackView.layer.borderColor = [UIColor generalSubTitleFontGrayColor].CGColor;
        _identityBackView.layer.borderColor = [UIColor mainColorBlue].CGColor;
        _dynamicView.layer.borderColor = [UIColor generalSubTitleFontGrayColor].CGColor;
    } else {
        _phoneBackView.layer.borderColor = [UIColor generalSubTitleFontGrayColor].CGColor;
        _identityBackView.layer.borderColor = [UIColor generalSubTitleFontGrayColor].CGColor;
        _dynamicView.layer.borderColor = [UIColor mainColorBlue].CGColor;
    }
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_phoneTextFiled resignFirstResponder];
    [_identityTextFiled resignFirstResponder];
    [_locateCodeTextFiled resignFirstResponder];
    
    _phoneBackView.layer.borderColor = [UIColor generalSubTitleFontGrayColor].CGColor;
    _identityBackView.layer.borderColor = [UIColor generalSubTitleFontGrayColor].CGColor;
    _dynamicView.layer.borderColor = [UIColor generalSubTitleFontGrayColor].CGColor;


}

#pragma mark Actions
//获取验证码
- (void )getIdentity:(UIButton *)button {
    
    [YMHIdenCodeTool idenCodeActionWithButton:button controller:self phoneNum:_phoneTextFiled.text];
    
}

- (void)userGuide:(UIButton *)button  {
    UserGuideViewController *vc = [[UserGuideViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)selectUserGuide:(UIButton *)button {
//    if (self.selectUserGuide) {
//        [button setBackgroundImage:[UIImage imageNamed:@"login-selected"] forState:(UIControlStateNormal)];
//
//    } else {
//        [button setBackgroundImage:[UIImage imageNamed:@"login-pre"] forState:(UIControlStateNormal)];
//
//    }
//
//    self.selectUserGuide = !self.selectUserGuide;

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
