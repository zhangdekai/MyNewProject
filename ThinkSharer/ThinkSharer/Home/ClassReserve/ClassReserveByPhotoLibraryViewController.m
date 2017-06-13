//
//  ClassReserveByPhotoLibraryViewController.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/13.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "ClassReserveByPhotoLibraryViewController.h"
#import "PhotoLibraryCollectionViewCell.h"

@interface ClassReserveByPhotoLibraryViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;



@end

@implementation ClassReserveByPhotoLibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];
    [self initilizeUI];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)initNavigationBar {
    
    [self setNavigationBarBack];
    [self setNavigationBarTitle:@"相册".internationalLanguage];
    [self setNavigationBarRightItemWithTitle:@"订制".internationalLanguage itemBlock:^{
        NSLog(@"");
    }];
}
- (void)initilizeUI {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor backgroundGrayColorB];
    
    [self.view addSubview:self.collectionView];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor backgroundGrayColorA];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"PhotoLibraryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PhotoLibraryCollectionViewCell"];
    
}

#pragma mark UICollectionViewDelegate UICollectionViewDatasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PhotoLibraryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoLibraryCollectionViewCell" forIndexPath:indexPath];
    cell.photoImageView.image = [UIImage imageNamed:@"testHeader"];
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(ScreenWidth, 300);
    
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
