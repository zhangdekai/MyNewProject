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

@interface SelectClassViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) UITableView *tableView;


@property (nonatomic,strong) NSMutableArray *sectionArray;
@property (nonatomic,strong) NSMutableDictionary *datasource;
@property (nonatomic,assign) CGFloat  tableCellHeight;
@property (nonatomic,strong) NSMutableArray *rowCellCount;

@property (nonatomic,strong) NSMutableArray *array;
@property (nonatomic,strong) NSMutableArray *array1;
@property (nonatomic,strong) NSMutableArray *array2;



@end

@implementation SelectClassViewController

#pragma mark life style
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"选择课程"];
    [self initilizeUI];
    
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.hidesBackButton = YES;
    
}

#pragma mark UI
- (void)setNavigationBarRightItem {

    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction)];
    
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    [self.navigationItem.rightBarButtonItem setImage:[[UIImage imageNamed:@"login_x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
}

- (void)initData {
    self.tableCellHeight = [TSPublicTool getRealPX:44];
    
    self.sectionArray = [NSMutableArray arrayWithObjects:@"数据库",@"求职", @"金融理财",  nil];
    self.datasource = [NSMutableDictionary dictionary];
    
    self.array = [NSMutableArray arrayWithObjects:@"sybase",@"Mysql", @"Mysql", @"sybase",@"Mysql", @"Mysql",@"sybase",@"Mysql", @"Mysql",@"sybase",@"Mysql", @"Mysql",@"sybase",@"Mysql", @"Mysql", nil];
    self.array1 = [NSMutableArray arrayWithObjects:@"面试技巧",@"大学生就业指导", @"职业规划", @"面试技巧",@"大学生就业指导", @"职业规划",@"职业规划", nil];
    self.array2 = [NSMutableArray arrayWithObjects:@"黄金",@"基金", @"理财", @"黄金",@"基金", @"理财",@"黄金",@"基金", @"理财", nil];

    [self.datasource setObject:self.array forKey:@"数据库"];
    [self.datasource setObject:self.array1 forKey:@"求职"];
    [self.datasource setObject:self.array2 forKey:@"金融理财"];

}

- (void)initilizeUI {
    
    [self setNavigationBarRightItem];
    
    NSMutableArray *items = [NSMutableArray arrayWithObjects:@"胎教",@"幼教",@"小学",@"初中",@"高中",@"大学",@"职教", @"胎教",@"幼教",@"小学",@"初中",@"高中",@"大学",@"职教",nil];
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 50)];
    [self.view addSubview:backView];
    
    SelectScrollView *selcetView = [[SelectScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50) selectItems:items];
    [backView addSubview:selcetView];
    [backView addShadowWithoutCorner];
    TSWeakSelf
    selcetView.selectItem = ^(NSString *title) {
        NSLog(@"%@",title);
        
        if ([title isEqualToString:@"胎教"]) {
            NSMutableArray *items = [NSMutableArray arrayWithObjects:@"一个月",@"二个月",@"三个月",@"四个月",@"五个月",@"六个月",@"七个月教", @"八个月",@"九个月",@"十个月",nil];
            SelectScrollViewForM *selcetView = [[SelectScrollViewForM alloc]initWithFrame:CGRectMake(0, 64 + 60, ScreenWidth, 50) selectItems:items];
            [weakSelf.view addSubview:selcetView];
            [selcetView addShadowWithoutCorner];
            selcetView.selectItem = ^(NSString *title) {
                NSLog(@"%@",title);
                
                
                
            };
            
            
            
            weakSelf.collectionView.hidden = YES;
            [weakSelf.view sendSubviewToBack:weakSelf.collectionView];
        }
        
    };
    
    [self initCollectionView];
}
- (void)initTableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64 + 120, ScreenWidth, ScreenHeight - 184)style:(UITableViewStylePlain)];
        
    }
    [self.view addSubview:_tableView];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
}
- (void)initCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    if (!self.collectionView) {
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64 + 53, ScreenWidth, ScreenHeight - 64 - 51) collectionViewLayout:layout];

    }
    [self.view addSubview:self.collectionView];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SelectClassCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SelectClassCollectionViewCell"];
    [self.collectionView registerClass:[SelectClassheaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SelectClassheaderView"];
    [self.collectionView registerClass:[SelectClassFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"SelectClassFooterView"];
    

}
#pragma mark Action
- (void)leftItemAction {
    MainViewController *vc = [[MainViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.sectionArray.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSMutableArray *tmpArray = [self.datasource objectForKey:self.sectionArray[section]];
    
    return tmpArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SelectClassCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectClassCollectionViewCell" forIndexPath:indexPath];
    
    NSMutableArray *tmpArray = [self.datasource objectForKey:self.sectionArray[indexPath.section]];

    cell.titleLabel.text = tmpArray[indexPath.row];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        SelectClassheaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SelectClassheaderView" forIndexPath:indexPath];
        [header setHeaderTitle:self.sectionArray[indexPath.section]];
        
        return header;
    
    } else {
        SelectClassFooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"SelectClassFooterView" forIndexPath:indexPath];
        
        return footer;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(ScreenWidth, 44);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    return CGSizeMake(ScreenWidth, 15);

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(ScreenWidth / 3, 44);
    
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

    NSLog(@"%@",self.array[indexPath.row]);
    MainViewController *vc = [[MainViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
//    TestViewController *vc = [[TestViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];


}
@end
