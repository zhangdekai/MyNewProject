//
//  SharerCenterViewController.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/5/19.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "SharerCenterViewController.h"
#import "SharerFirstCollectionViewCell.h"
#import "SharerScendCollectionViewCell.h"
#import "SharerThirdCollectionViewCell.h"
#import "ShareFourceCollectionViewCell.h"
#import "UserShareCenterCollectionReusableView.h"
#import "UserShareCenterFotterCollectionReusableView.h"
#import <PYPhotoBrowser/PYPhotoBrowser.h>
#import "ShareMessageViewController.h"


@interface SharerCenterViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,copy) NSArray *scondCellData;
@property (nonatomic,copy) NSArray *thirdCellIconData;
@property (nonatomic,copy) NSArray *fourthCellIconData;
@property (nonatomic,copy) NSArray *fourthCellData;


@end

@implementation SharerCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBar];
    [self initilizeUI];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self addShadow];

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self hiddenShadow];
}

-(void)initData {
    _scondCellData = [NSArray arrayWithObjects:@"资产",@"预定",@"发布",nil];
    _thirdCellIconData = [NSArray arrayWithObjects:@"user_zan",@"user_xin",@"user_hongbao",@"user_guanzhu",@"user_pinglun",@"user_fenxiang",nil];
    _fourthCellIconData = [NSArray arrayWithObjects:@"user_zhanghao",@"user_yinsi",@"user_help",@"user_ue",@"user_new",@"user_tui",nil];
    _fourthCellData = [NSArray arrayWithObjects:@"账号与安全",@"隐私权限",@"帮助与反馈",@"关于我们",@"版本更新",@"退出登录",nil];
    
}

- (void)initilizeUI {
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor backgroundGrayColorB];

    [self.view addSubview:self.collectionView];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor backgroundGrayColorA];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SharerFirstCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SharerFirstCollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SharerScendCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SharerScendCollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SharerThirdCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SharerThirdCollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ShareFourceCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ShareFourceCollectionViewCell"];

    
    
    [self.collectionView registerClass:[UserShareCenterCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UserShareCenterCollectionReusableView"];
    [self.collectionView registerClass:[UserShareCenterFotterCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UserShareCenterFotterCollectionReusableView"];
}

- (void)setNavigationBar {
    [self setNavigationBarTitle:@"思享者中心"];
    TSWeakSelf
    [self setNavigationBarRightItemWithImageName:@"user_QR-code" itemBlock:^{
        NSLog(@"你好");
    }];
    
    [self setNavigationBarLeftItemWithImageName:@"navigation_back" itemBlock:^{
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];

}

- (void)selectPersonOrCompany {
    PersonalOrCompanyView *person = [[PersonalOrCompanyView alloc]initWithFrame:CGRectZero];//[TSPublicTool personInstance];
    [person showInView];
    TSWeakSelf
    person.SelectPersonOrCompany = ^(NSInteger index) {
        NSLog(@"%ld",index);
        if (index == 0) {
            ShareMessageViewController *vc = [[ShareMessageViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        } else {
            
        }
    };
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 6;
            break;
        case 3:
            return 6;
            break;
            
        default:
            return 0;

            break;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        SharerFirstCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SharerFirstCollectionViewCell" forIndexPath:indexPath];
        
        __weak typeof(cell)weakCell = cell;
        
        cell.headerImageBlock = ^{
            // 1. 创建photoBroseView对象
            PYPhotoBrowseView *photoBroseView = [[PYPhotoBrowseView alloc] init];
            
            // 2.1 设置图片源(UIImageView)数组
            NSArray *array = [NSArray arrayWithObjects:weakCell.headerImageView, nil];
            photoBroseView.sourceImgageViews = array;
            // 2.2 设置初始化图片下标（即当前点击第几张图片）
            photoBroseView.currentIndex = 0;
            
            // 3.显示(浏览)
            [photoBroseView show];
        };
        
        return cell;
    } else if (indexPath.section == 1) {
        SharerScendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SharerScendCollectionViewCell" forIndexPath:indexPath];
        
        [cell setModel:_scondCellData[indexPath.row]];
        
        return cell;
    }  else if (indexPath.section == 2) {
        SharerThirdCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SharerThirdCollectionViewCell" forIndexPath:indexPath];
        
        [cell setModel:_thirdCellIconData[indexPath.row]];

        return cell;
    } else  {
        ShareFourceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShareFourceCollectionViewCell" forIndexPath:indexPath];
        [cell setModel:_fourthCellData[indexPath.row] iocn:_fourthCellIconData[indexPath.row]];

        
        return cell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            UserShareCenterCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UserShareCenterCollectionReusableView" forIndexPath:indexPath];
            
            return header;
            
        } else {
            UserShareCenterFotterCollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UserShareCenterFotterCollectionReusableView" forIndexPath:indexPath];
            
            return footer;
        }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 3) {
        return CGSizeMake(ScreenWidth, 15);
    }
    return CGSizeMake(ScreenWidth, 0.0001);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    return CGSizeMake(ScreenWidth, 0.00001);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return CGSizeMake(ScreenWidth, 147);

            break;
        case 1:
            return CGSizeMake((ScreenWidth - 60) / 3, 95);
            
            break;
        case 2:
            
            return CGSizeMake((ScreenWidth - 60) / 3, 80);
            
            break;
        case 3:
            return CGSizeMake(ScreenWidth , 65);
            
            break;
            
        default:
            return CGSizeMake(ScreenWidth, 0.0001);

            break;
    }
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    switch (section) {
        case 0:
            return UIEdgeInsetsMake(0, 0, 0, 0);
            
            break;
        case 1:
            return UIEdgeInsetsMake(0, 15, 0, 15);
            
            break;
        case 2:
            return UIEdgeInsetsMake(0, 15, 0, 15);
            
            break;
        case 3:
            return UIEdgeInsetsMake(0, 0, 0, 0);
            
            break;
            
        default:
            return UIEdgeInsetsMake(0, 0, 0, 0);
            
            break;
    }

}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
   
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [self selectPersonOrCompany];
    }
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
