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
#import "ThinkSharer-Swift.h"


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
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addShadow];
    [self setNavigationBar];
    [self initData];
    [self initilizeUI];


}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self hiddenShadow];
}

-(void)initData {
    _scondCellData = [NSArray arrayWithObjects:@"资产",@"预定",@"发布",nil];
    _thirdCellIconData = [NSArray arrayWithObjects:@"user_zan",@"user_xin",@"user_hongbao",@"user_guanzhu",@"user_pinglun",@"user_fenxiang",nil];
    _fourthCellIconData = [NSArray arrayWithObjects:@"user_zhanghao",@"user_yinsi",@"user_yuyan",@"user_help",@"user_ue",@"user_new",@"user_tui",nil];
    /*
    "Account and security" = "账号与安全";
    "Privacy rights" = "隐私权限";
    "Language Settings" = "语言设置";
    "Help and feedback" = "帮助与反馈";
    "About us" = "关于我们";
    "Version update" = "版本更新";
     "Log out" = "退出登录";
     */
    NSString *string1 = NSLocalizedString(@"Account and security", @"账号与安全");
     NSString *string2 = NSLocalizedString(@"Privacy rights", @"隐私权限");
    NSString *string3 = NSLocalizedString(@"Language Settings", @"语言设置");
     NSString *string4 = NSLocalizedString(@"Help and feedback", @"帮助与反馈");
     NSString *string5 = NSLocalizedString(@"About us", @"关于我们");
     NSString *string6 = NSLocalizedString(@"Version update", @"版本更新");
    NSString *string7 = NSLocalizedString(@"Log out", @"退出登录");

    
    
    _fourthCellData = [NSArray arrayWithObjects:string1,string2,string3,string4,string5,string6,string7,nil];
    
}

- (void)initilizeUI {
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) collectionViewLayout:layout];
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
    NSString *title = NSLocalizedString(@"thinkSharerCenter", nil);
    [self setNavigationBarTitle:title];
    TSWeakSelf
    [self setNavigationBarRightItemWithImageName:@"user_QR-code" itemBlock:^{
        NSLog(@"你好");
    }];
    
    [self setNavigationBarLeftItemWithImageName:@"navigation_back" itemBlock:^{
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];

}

- (void)selectPersonOrCompany {
//    PersonalOrCompanyView *person = [[PersonalOrCompanyView alloc]initWithFrame:CGRectZero];
//    [person showInView];
//    TSWeakSelf
//    person.SelectPersonOrCompany = ^(NSInteger index) {
//        NSLog(@"%ld",index);
//        if (index == 0) {
            ShareMessageViewController *vc = [[ShareMessageViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
//            
//        } else {
//            
//        }
//    };
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
            return _fourthCellData.count;
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
        [cell.headerImageView TSLoadAvertWithTFSKey:@"http://ww1.sinaimg.cn/large/536e7093jw1f6bqdj3lpjj20va134ana.jpg"];
        TSWeakSelf
        cell.headerImageBlock = ^{
            [weakSelf browerPhotos:@[weakCell.headerImageView] touchIndex:0];
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
            return CGSizeMake(ScreenWidth, 162);

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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
            [self selectPersonOrCompany];
            break;
        case 1: {
            if (indexPath.row == 0) {//资产
            } else if (indexPath.row == 1) {//预定
                
            } else {//发布
                
            }

        }
            
            break;
        case 2: {
            
            if (indexPath.row == 0) {  //点赞

                
            } else if (indexPath.row == 1) {//收藏
                
            } else if (indexPath.row == 2) { //红包
                
            } else if (indexPath.row == 3) {//浏览
                
            } else if (indexPath.row == 4) {//评论
                
            } else if (indexPath.row == 5) {//分享
                
            }
            
        }
            
            break;
        case 3: {
            
            
            if (indexPath.row == 0) { //账号与安全
                
                AccountSecureViewController *vc = [[AccountSecureViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];

            } else if (indexPath.row == 1) {//隐私权限
                PrivacyViewController *vc = [[PrivacyViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
                
            } else if (indexPath.row == 2) {//语言设置
                
                UserLangageViewController *vc = [[UserLangageViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
                
            } else if (indexPath.row == 3) {//帮助鱼反馈
                
                UserCenterHelpFeedbackViewController *vc = [[UserCenterHelpFeedbackViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
                
            } else if (indexPath.row == 4) {//关于我们
                
                UserAbloutUsViewController *vc = [[UserAbloutUsViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
                
            } else if (indexPath.row == 5) {//版本更新
                
            } else {//退出登录
                
            }
        }
            
            break;
            
        default:
            break;
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
