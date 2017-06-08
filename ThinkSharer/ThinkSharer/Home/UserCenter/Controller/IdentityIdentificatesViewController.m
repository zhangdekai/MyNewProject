//
//  IdentityIdentificatesViewController.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/5.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "IdentityIdentificatesViewController.h"
#import "ThinkSharer-Swift.h"
#import "CTAssetsPickerController.h"
#import <Photos/Photos.h>
#import <MobileCoreServices/MobileCoreServices.h>


@interface IdentityIdentificatesViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIImage *frontPhoto;
@property (nonatomic,strong) UIImage *backPhoto;

@property (nonatomic,assign) NSInteger selectedIndex;
@end

@implementation IdentityIdentificatesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)setNavigationBar {
    [self setNavigationBarTitle:@"身份证认证"];
    [self setNavigationBarBack];
    TSWeakSelf
    [self setNavigationBarRightItemWithTitle:@"保存" itemBlock:^{
        
       
    }];
}

- (void)initUI {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:(UITableViewStylePlain)];
    }
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerClass:[IdentityIdentificateCell class] forCellReuseIdentifier:@"IdentityIdentificateCell"];
    
}

- (void)selectedPhoto:(NSArray *)photos {
    if (_selectedIndex == 0) {
        
        self.frontPhoto = photos[0];

    } else {
        
        self.backPhoto = photos[0];


    }
    [_tableView reloadData];
}

#pragma mark UITableViewDelegate UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 240;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IdentityIdentificateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IdentityIdentificateCell"];
    [cell hiddenWithHidden:YES];
    if (indexPath.row == 0) {
        cell.identityLabel.text = @"身份证正面照";

    } else {
        
        cell.identityLabel.text = @"身份证反面照";

    }
    
    if (_selectedIndex == 0) {
        if (_frontPhoto) {
            cell.showImageView.image = _frontPhoto;
            [cell hiddenWithHidden:YES];
        } else {
            cell.showImageView.image = nil;
            [cell hiddenWithHidden:NO];
        }
    } else {
        if (_backPhoto) {
            cell.showImageView.image = _frontPhoto;
            [cell hiddenWithHidden:YES];
        } else {
            cell.showImageView.image = nil;
            [cell hiddenWithHidden:NO];
        }

    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedIndex = indexPath.row;
    [self selectPhoto:1];
}


@end
