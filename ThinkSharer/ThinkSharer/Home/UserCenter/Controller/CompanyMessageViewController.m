//
//  CompanyMessageViewController.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/4.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "CompanyMessageViewController.h"
#import "CompanyTableHeaderView.h"


#import "CTAssetsPickerController.h"
#import "ShareMessageTableHeaderView.h"
#import <Photos/Photos.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "TSDatePickerView.h"
#import "ThinkSharer-Swift.h"
#import "ShareMessageFirstCell.h"
#import "ShareMessageSecondCell.h"
#import "ShareMessageThirdCell.h"
#import "ShareMessageFourthCell.h"



@interface CompanyMessageViewController ()
///<,UITableViewDataSource,CTAssetsPickerControllerDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UITextViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) CompanyTableHeaderView *tableHeaderView;

@end

@implementation CompanyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
}

- (void)setNavigationBar {
    [self setNavigationBarTitle:@"机构信息"];
    [self setNavigationBarBack];
//    TSWeakSelf
    [self setNavigationBarRightItemWithTitle:@"保存" itemBlock:^{
        NSLog(@"%@",@"sdfsd");
    
    }];
}

- (void)initUI {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:(UITableViewStylePlain)];
    }
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.showsVerticalScrollIndicator = NO;
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
    
    [_tableView registerClass:[ShareMessageFirstCell class] forCellReuseIdentifier:@"ShareMessageFirstCell"];
    [_tableView registerClass:[ShareMessageSecondCell class] forCellReuseIdentifier:@"ShareMessageSecondCell"];
    [_tableView registerClass:[ShareMessageThirdCell class] forCellReuseIdentifier:@"ShareMessageThirdCell"];
    [_tableView registerClass:[ShareMessageFourthCell class] forCellReuseIdentifier:@"ShareMessageFourthCell"];
    
    
    
    [self initTableHeaderView];
    [self initTableFooterView];
    
}

- (void)initTableHeaderView {
    
    _tableHeaderView = [[CompanyTableHeaderView alloc]init];
    
    _tableView.tableHeaderView = _tableHeaderView;
    
    TSWeakSelf
    _tableHeaderView.SelectPhotoBlock = ^{
        [weakSelf selectPhoto:1];
    };
    
}

- (void)initTableFooterView {
    ShareMessageTableFooterView *footer = [[ShareMessageTableFooterView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
    _tableView.tableFooterView = footer;
    
}



@end
