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


@end

@implementation LoginViewController

#pragma mark life style
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
    
    [_getIdentityButton addTarget:self action:@selector(getIdentity:) forControlEvents:(UIControlEventTouchUpInside)];
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

//登录
- (IBAction)login:(id)sender {
    
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
