//
//  SelectClassViewController.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/17.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "SelectClassViewController.h"
#import "SelectScrollView.h"
#import "SelectClassheaderView.h"
#import "SelectClassTableViewCell.h"
#import "SelectClassFooterView.h"
#import "SelectClassCollectionViewCell.h"
#import "MainViewController.h"
#import "SelectScrollViewForM.h"
#import "SelectClassLeftTableViewCell.h"



@interface SelectClassViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *sectionArray;
@property (nonatomic,strong) NSMutableDictionary *datasource;
@property (nonatomic,assign) CGFloat  tableCellHeight;
@property (nonatomic,strong) NSMutableArray *rowCellCount;
@property (nonatomic,strong) SelectScrollViewForM *selectView;

@property (nonatomic,strong) NSMutableArray *array;
@property (nonatomic,strong) NSMutableArray *array1;
@property (nonatomic,strong) NSMutableArray *array2;

@property (nonatomic,strong) NSMutableArray *tableViewDataSource;





@property (nonatomic,strong) UITableView *leftTableView;
@property (nonatomic,strong) UICollectionView *rightCollectionView;
@property (nonatomic,strong) NSMutableArray *leftDateArray;
@property (nonatomic,strong) NSMutableArray *rightDateArray;

@property (nonatomic,copy) NSString *selectedItem;
@property (nonatomic,copy) NSString *selectedItem1;


@end

@implementation SelectClassViewController

#pragma mark life style
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarTitle:@"选择课程" titleColor:[UIColor whiteColor]];
    [self initilizeUI];
    
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor mainColorBlue];

    
}
- (void)viewDidAppear:(BOOL)animated {
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [self.leftTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];

}
#pragma mark UI
- (void)setNavigationBarRightItem {

    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction)];
    
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    [self.navigationItem.rightBarButtonItem setImage:[[UIImage imageNamed:@"login_whiteX"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
}

- (void)initData {
    self.tableCellHeight = [TSPublicTool getRealPX:44];
    
    self.sectionArray = [NSMutableArray arrayWithObjects:@"数据库",@"求职", @"金融理财",  nil];
    self.datasource = [NSMutableDictionary dictionary];
    
    self.array = [NSMutableArray arrayWithObjects:@"sybase",@"Mysql", @"Mysql", @"sybase",@"Mysql", @"Mysql",@"sybase",@"Mysql", @"Mysql",@"sybase",@"Mysql", @"Mysql",@"sybase",@"Mysql", @"Mysql", nil];
    self.array1 = [NSMutableArray arrayWithObjects:@"面试技巧",@"大学生就业指导", @"职业规划", @"面试技巧",@"大学生就业指导", @"职业规划",@"职业规划", nil];
    self.array2 = [NSMutableArray arrayWithObjects:@"黄金",@"基金", @"理财", @"黄金",@"基金", @"理财",@"黄金",@"基金", @"理财", nil];

}

- (void)initilizeUI {
    
    if (!_backSearchClass) {
        [self setNavigationBarRightItem];
    }
    self.view.backgroundColor = [UIColor backgroundGrayColorA];
    NSMutableArray *items = [NSMutableArray arrayWithObjects:@"胎教",@"幼教",@"小学",@"初中",@"高中",@"大学",@"职教", @"胎教",@"幼教",@"小学",@"初中",@"高中",@"大学",@"职教",nil];
    
    NSMutableArray *items1 = [NSMutableArray arrayWithObjects:@"一个月",@"二个月",@"三个月",@"四个月",@"五个月",@"六个月",@"七个月", @"八个月",@"九个月",@"十个月",nil];

    NSMutableArray *items2 = [NSMutableArray arrayWithObjects:@"一岁",@"二岁",@"三岁",@"四岁",@"五岁",@"六岁",@"七岁", nil];
    NSMutableArray *items3 = [NSMutableArray arrayWithObjects:@"一年级",@"二年级",@"三年级",@"四年级",@"五年级",@"六年级", nil];
    NSMutableArray *items4 = [NSMutableArray arrayWithObjects:@"初一",@"初二",@"初三", nil];
    NSMutableArray *items5 = [NSMutableArray arrayWithObjects:@"高一",@"高二",@"高三", nil];
    NSMutableArray *items6 = [NSMutableArray arrayWithObjects:@"大一",@"大二",@"大三",@"大四", nil];
    NSMutableArray *items7 = [NSMutableArray arrayWithObjects:@"数据库",@"求职",@"金融理财", nil];


    
     NSMutableArray *primary = [NSMutableArray arrayWithObjects:@"语文",@"数学",@"英语",@"物理",@"化学",@"政治",@"科学",@"生活",@"品德", nil];
    NSMutableArray *array3 = [NSMutableArray arrayWithObjects:@"心音胎教",@"情绪胎教",@"音乐胎教",@"胎教故事",@"语言",@"抚摸",@"运动",@"饮食",@"微笑",@"语言",@"抚摸",@"运动",@"饮食",@"微笑",@"语言",@"抚摸",@"运动",@"饮食",@"微笑", nil];
    
    
    _selectedItem = items[0];
    _leftDateArray = [NSMutableArray arrayWithArray:items1];
    _selectedItem1 = _leftDateArray[0];
    
    _rightDateArray = [NSMutableArray arrayWithArray:array3];

    _tableViewDataSource = [NSMutableArray array];
    _tableViewDataSource =  [TSPublicTool convertArray:array3];
    
    SelectScrollView *selcetView = [[SelectScrollView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 50) selectItems:items];
    [self.view addSubview:selcetView];
    
    TSWeakSelf
    selcetView.selectItem = ^(NSString *title) {
        weakSelf.selectedItem = title;
        NSLog(@"%@",title);
        if (_leftDateArray.count != 0) {
            [_leftDateArray removeAllObjects];
        }
        
        if ([title isEqualToString:@"职教"]) {
            _leftDateArray = [NSMutableArray arrayWithArray:items7];
            _rightDateArray = [NSMutableArray arrayWithArray:self.array];
        } else if ( [title isEqualToString:@"胎教"]) {
            _leftDateArray = [NSMutableArray arrayWithArray:items1];
            _rightDateArray = [NSMutableArray arrayWithArray:array3];

        } else if ( [title isEqualToString:@"幼教"]) {
            _leftDateArray = [NSMutableArray arrayWithArray:items2];
        } else if ( [title isEqualToString:@"小学"]) {
            _leftDateArray = [NSMutableArray arrayWithArray:items3];
            _rightDateArray = [NSMutableArray arrayWithArray:primary];

        }else if ( [title isEqualToString:@"初中"]) {
            _leftDateArray = [NSMutableArray arrayWithArray:items4];
            _rightDateArray = [NSMutableArray arrayWithArray:primary];

        } else if ( [title isEqualToString:@"高中"]) {
            _leftDateArray = [NSMutableArray arrayWithArray:items5];
            _rightDateArray = [NSMutableArray arrayWithArray:primary];

        }else if ( [title isEqualToString:@"大学"]) {
            _leftDateArray = [NSMutableArray arrayWithArray:items6];
            _rightDateArray = [NSMutableArray arrayWithArray:primary];

        }
        
        if (_rightDateArray.count!= 0 && _rightDateArray.count / 2 != 0) {
            [_rightDateArray addObject:@""];
        }
        weakSelf.selectedItem1 = weakSelf.leftDateArray[0];
        [weakSelf.leftTableView reloadData];
        [weakSelf.rightCollectionView reloadData];
        
        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [self.leftTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];

    };
    UIView *grayLine = [[UIView alloc]initWithFrame:CGRectMake(0, _selectView.bottom, ScreenWidth, 15)];
    [self.view addSubview:grayLine];
    grayLine.backgroundColor = [UIColor backgroundGrayColorA];
    
    [self initLeftTableView];
    [self initRightCollectionView];
}

- (void)initLeftTableView {
    if (_leftTableView == nil) {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64 + 50 + 15, 110, ScreenHeight - 129)style:(UITableViewStylePlain)];
    }
    [self.view addSubview:_leftTableView];
    _leftTableView.backgroundColor = [UIColor backgroundGrayColorA];
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _leftTableView.dataSource = self;
    _leftTableView.delegate = self;
    [_leftTableView registerClass:[SelectClassLeftTableViewCell class] forCellReuseIdentifier:@"SelectClassLeftTableViewCell"];
    
}

- (void)initRightCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    if (self.rightCollectionView == nil) {
        self.rightCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(110, 64 + 50 + 15, ScreenWidth - 110, ScreenHeight - 64 - 50 - 15) collectionViewLayout:layout];

    }
    [self.view addSubview:self.rightCollectionView];
    self.rightCollectionView.showsVerticalScrollIndicator = NO;
    self.rightCollectionView.backgroundColor = [UIColor whiteColor];
    self.rightCollectionView.delegate = self;
    self.rightCollectionView.dataSource = self;

    [self.rightCollectionView registerNib:[UINib nibWithNibName:@"SelectClassCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SelectClassCollectionViewCell"];
}


#pragma mark UITableViewDelegate UItableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _leftDateArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    SelectClassLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectClassLeftTableViewCell"];

    if (indexPath.row == 0) {
        cell.selected = YES;
    }

    if (_leftDateArray.count != 0) {
        [cell setLeftModel:_leftDateArray[indexPath.row]];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_leftDateArray.count != 0) {
        _selectedItem1 = _leftDateArray[indexPath.row];
    }

    if ([_selectedItem isEqualToString:@"职教"]) {
        switch (indexPath.row) {
            case 0:
                _rightDateArray = [NSMutableArray arrayWithArray:_array];
                break;
            case 1:
                _rightDateArray = [NSMutableArray arrayWithArray:_array1];

                break;
            case 2:
                _rightDateArray = [NSMutableArray arrayWithArray:_array2];

                break;
            default:
                _rightDateArray = [NSMutableArray arrayWithArray:_array];

                break;
        }
        if (_rightDateArray.count!= 0 && _rightDateArray.count / 2 != 0) {
            [_rightDateArray addObject:@""];
        }
        [_rightCollectionView reloadData];
    }
}

#pragma mark UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return _rightDateArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    SelectClassCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectClassCollectionViewCell" forIndexPath:indexPath];
    if (_rightDateArray.count != 0) {
        cell.titleLabel.text = _rightDateArray[indexPath.row];
    }

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake((ScreenWidth - 110) / 2, 50);

}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (_rightDateArray.count != 0) {
        if (_rightDateArray.count != indexPath.row) {
            NSString *lastString = [NSString stringWithFormat:@"%@%@%@",_selectedItem,_selectedItem1,
                                    _rightDateArray[indexPath.row]];
            if (_backSearchClass) {
                self.backSearchClassWithKey(lastString);
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                MainViewController *vc = [[MainViewController alloc]init];
                vc.keyWord = lastString;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }
    NSLog(@"%@",self.rightDateArray[indexPath.row]);

//    TestViewController *vc = [[TestViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];


}

#pragma mark Private Method
- (void)leftItemAction {
    MainViewController *vc = [[MainViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}

@end
