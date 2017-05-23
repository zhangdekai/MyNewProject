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

@interface SharerCenterViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;


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
}

- (void)initilizeUI {
    
    [self addShadow];
    
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

    
    
//    [self.collectionView registerClass:[SelectClassheaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SelectClassheaderView"];
//    [self.collectionView registerClass:[SelectClassFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"SelectClassFooterView"];
}

- (void)setNavigationBar {
    [self setNavigationBarTitle:@"思享者中心"];
    TSWeakSelf
    [self setNavigationBarRightItemWithImageName:@"login_x" itemBlock:^{
        NSLog(@"你好");
    }];
    
    [self setNavigationBarLeftItemWithImageName:@"navigation_back" itemBlock:^{
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];

}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
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
            
        default:
            return 0;

            break;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        SharerFirstCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SharerFirstCollectionViewCell" forIndexPath:indexPath];
        
        
        return cell;
    } else if (indexPath.section == 1) {
        SharerScendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SharerScendCollectionViewCell" forIndexPath:indexPath];
        
        
        return cell;
    } else  {
        SharerThirdCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SharerThirdCollectionViewCell" forIndexPath:indexPath];
        
        
        return cell;
    }
//    SharerFirstCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SharerFirstCollectionViewCell" forIndexPath:indexPath];
//    
//    
//    return cell;
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        SelectClassheaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SelectClassheaderView" forIndexPath:indexPath];
//        [header setHeaderTitle:self.sectionArray[indexPath.section]];
//        
//        return header;
//        
//    } else {
//        SelectClassFooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"SelectClassFooterView" forIndexPath:indexPath];
//        
//        return footer;
//    }
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    
//    return CGSizeMake(ScreenWidth, 44);
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    
//    return CGSizeMake(ScreenWidth, 10);
//    
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return CGSizeMake(ScreenWidth, 147);

            break;
        case 1:
            return CGSizeMake((ScreenWidth - 60) / 3, 100);
            
            break;
        case 2:
            return CGSizeMake((ScreenWidth - 60) / 3, 80);
            
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
