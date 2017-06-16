//
//  ClassSearchAndReserveViewController.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/15.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "ClassSearchAndReserveViewController.h"
#import "SelectClassViewController.h"
#import "ClassSearchTableViewCell.h"
#import "SelectScrollView.h"
#import "ClassSearchModel.h"
#import "ClassSearchViewController.h"


/**
 学习 授课 搜索定制课程
 */

@interface ClassSearchAndReserveViewController ()<UITextFieldDelegate,UITableViewDelegate,
UITableViewDataSource>
@property (nonatomic,strong) UIImageView *navBarHairlineImageView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) TSCustomTextFiled *navigationBarTextFiled;
@property (nonatomic,strong) UIButton *searchClassButton;
@property (nonatomic,strong) UIButton *deleteTextButton;
@property (nonatomic,strong) NSMutableArray *leftDataArray;
@property (nonatomic,strong) NSMutableArray *rightDataArray;
@property (nonatomic,assign) NSInteger selectIndex;


@end

@implementation ClassSearchAndReserveViewController


#pragma mark - View Controller LifeCyle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialNavigationBar];
    [self initilizeTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    // 隐藏导航栏下的黑线
    _navBarHairlineImageView.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _navBarHairlineImageView.hidden = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Initial Methods

- (void)initData {
    _selectIndex = 0;
    ClassSearchModel *model = [[ClassSearchModel alloc]init];
    model.uplabelString = @"您可以设置相关条件搜索学习需求，以获得能力的提升。".internationalLanguage;
    model.buttonString = @"搜索课程".internationalLanguage;
    model.buttonColor = [UIColor ymh_colorWithHex:0x99ae75];
    
    ClassSearchModel *model1 = [[ClassSearchModel alloc]init];
    model1.uplabelString = @"您可以按照自己的个人需求制订学习计划，以获得有效的帮助。".internationalLanguage;
    model1.buttonString = @"订制课程".internationalLanguage;
    model1.buttonColor = [UIColor ymh_colorWithHex:0xdb665c];
    
    _leftDataArray = [NSMutableArray arrayWithObjects:model,model1, nil];
    
    ClassSearchModel *model2 = [[ClassSearchModel alloc]init];
    model2.uplabelString = @"您可以查找学习者的订制课程请求，并帮助TA以获得经济效益。".internationalLanguage;
    model2.buttonString = @"找订制课".internationalLanguage;
    model2.buttonColor = [UIColor mainColorBlue];
    
    ClassSearchModel *model3 = [[ClassSearchModel alloc]init];
    model3.uplabelString = @"您可以根据自己的专业特长发布技能帮助TA人，获得经济效益。".internationalLanguage;
    model3.buttonString = @"发布课程".internationalLanguage;
    model3.buttonColor =  [UIColor ymh_colorWithHex:0xdb665c];

    _rightDataArray = [NSMutableArray arrayWithObjects:model2,model3, nil];

}

- (void)initialNavigationBar {
    
    [self setNavigationBarBack];
    CGFloat titleViewW = [TSPublicTool getRealPX:250];
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, titleViewW, 30)];
    titleView.backgroundColor = [UIColor mainColorBlueA];
    titleView.layer.cornerRadius = 5;
    titleView.layer.masksToBounds = YES;
    
    _navigationBarTextFiled = [[TSCustomTextFiled alloc]initWithFrame:
                               CGRectMake(25, 0, titleView.width - 60, 30)];
    [titleView addSubview:_navigationBarTextFiled];
    _navigationBarTextFiled.MaxNum = 15;
    _navigationBarTextFiled.textColor = [UIColor whiteColor];
    _navigationBarTextFiled.font = [UIFont systemFontOfSize:16];
    _navigationBarTextFiled.keyboardType = UIKeyboardTypeWebSearch;
    _navigationBarTextFiled.delegate = self;
    _navigationBarTextFiled.text = _keyWord;
    
    _searchClassButton = [[UIButton alloc]initWithFrame:CGRectMake(25, 0, titleView.width - 60 , 30)];
    [titleView addSubview:_searchClassButton];
    [_searchClassButton addTarget:self action:@selector(goBackToSearchClassList) forControlEvents:(UIControlEventTouchUpInside)];
    
    _deleteTextButton = [[UIButton alloc]initWithFrame:CGRectMake(titleView.width - 15, 10, 12, 12)];
    [titleView addSubview:_deleteTextButton];
    [_deleteTextButton setBackgroundImage:[UIImage imageNamed:@"made-delete-text"]
                                 forState:(UIControlStateNormal)];
    [_deleteTextButton addTarget:self action:@selector(deleteText)
                forControlEvents:(UIControlEventTouchUpInside)];
    
    self.navigationItem.titleView = titleView;
    
    
}

- (void)textFiledTouchClick {
    
}

- (void)initilizeTableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:(UITableViewStyleGrouped)];
    }
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerNib:[UINib nibWithNibName:@"ClassSearchTableViewCell" bundle:nil] forCellReuseIdentifier:@"ClassSearchTableViewCell"];
    
    [self initTableHeaderView];
}

- (void)initTableHeaderView {
    NSString *first = @"学习".internationalLanguage;
    NSMutableArray *items = [NSMutableArray arrayWithObjects:first,@"授课".internationalLanguage, nil];
    SelectScrollView *selcetView = [[SelectScrollView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 50) selectItems:items maxNumInAline:2];
    
    _tableView.tableHeaderView = selcetView;
    TSWeakSelf
    selcetView.selectItem = ^(NSString *title) {
        if ([title isEqualToString:first]) {
            weakSelf.selectIndex = 0;
        } else {
            weakSelf.selectIndex = 1;
        }
        [weakSelf.tableView reloadData];
    };
    
}

#pragma mark Request Methods

- (void)requestData {
    
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    return YES;
}


#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 265;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ClassSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassSearchTableViewCell" forIndexPath:indexPath];
    TSWeakSelf
    if (_selectIndex == 0) {
        [cell setCellModel:_leftDataArray[indexPath.row]];
        cell.butonClickBlock = ^{
            if (indexPath.row == 0) {
                ClassSearchViewController *vc = [[ClassSearchViewController alloc]init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            } else {
                
            }
        };
    } else {
        [cell setCellModel:_rightDataArray[indexPath.row]];

    }
    
    return cell;
}



#pragma mark - Privater Methods

- (void)deleteText {
    
    _navigationBarTextFiled.text = @"";
    [_navigationBarTextFiled becomeFirstResponder];
    
}
- (void)goBackToSearchClassList {
    SelectClassViewController *vc = [[SelectClassViewController alloc]init];
    vc.backSearchClass = YES;
    TSWeakSelf
    vc.backSearchClassWithKey = ^(NSString *keyWord) {
        weakSelf.navigationBarTextFiled.text = keyWord;
    };
    [self.navigationController pushViewController:vc animated:YES];
}

// 寻找导航栏下的黑线
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

#pragma mark - Setter Getter Methods




@end
