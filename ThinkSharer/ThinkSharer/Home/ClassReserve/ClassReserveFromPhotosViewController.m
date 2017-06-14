//
//  ClassReserveFromPhotosViewController.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/14.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "ClassReserveFromPhotosViewController.h"
#import "LQScrollView.h"
#import "XLCardSwitch.h"

@interface ClassReserveFromPhotosViewController ()<UITableViewDelegate,UITableViewDataSource,
XLCardSwitchDelegate>

@property (nonatomic,strong) UITableView      *tableView;
@property (nonatomic,strong) LQScrollView     *lqScrollView;
@property (nonatomic,strong) XLCardSwitch     *cardSwitch;
@property (nonatomic,strong) UIImageView      *imageView;
@end

@implementation ClassReserveFromPhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavigationBar];
    [self initTableView];
    
    [self selectPhoto:5];
    
}

- (void)initNavigationBar {
    
    [self setNavigationBarBack];
    [self setNavigationBarTitle:@"相册".internationalLanguage];
    [self setNavigationBarRightItemWithTitle:@"订制".internationalLanguage itemBlock:^{
        NSLog(@"");
    }];
}

- (void)initTableView {
    
//    NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
//    _lqScrollView = [[LQScrollView alloc]initWithFrame:
//                     CGRectMake(0, 100, self.view.frame.size.width, 300) imageArray:arr];

    [self addImageView];
    //设置卡片浏览器
    _cardSwitch = [[XLCardSwitch alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 300)];
//    _cardSwitch.items = items;
    _cardSwitch.delegate = self;
    //分页切换
    _cardSwitch.pagingEnabled = true;
    //设置初始位置，默认为0
//    _cardSwitch.selectedIndex = 3;
    [_imageView addSubview:_cardSwitch];
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:(UITableViewStyleGrouped)];
    }
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.tableHeaderView = _imageView;

    //    [_tableView registerClass:[ShareMessageFirstCell class] forCellReuseIdentifier:@"ShareMessageFirstCell"];
}

#pragma mark CardSwitchDelegate

- (void)XLCardSwitchDidSelectedAt:(NSInteger)index {
    NSLog(@"选中了：%zd",index);
    _imageView.image = _cardSwitch.items[index].image;
    //更新背景图
//    XLCardItem *item = _cardSwitch.items[index];

}
- (void)addImageView {
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 300)];
//    [self.view addSubview:_imageView];
    _imageView.userInteractionEnabled = YES;
    UIBlurEffect* effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView* effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = _imageView.bounds;
    [_imageView addSubview:effectView];
    

}


- (void)selectedPhoto:(NSArray *)photos {
    
    NSMutableArray *items = [NSMutableArray new];
    for (UIImage *image in photos) {
        XLCardItem *item = [[XLCardItem alloc] init];
        item.image = image;
        item.title = @"三年级语文";
        [items addObject:item];
    }
    _cardSwitch.items = items;
    _cardSwitch.selectedIndex = 0;
    
//    [_lqScrollView setImageViewArray:photos];
}

#pragma mark UITableViewDelegate UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@" "];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
