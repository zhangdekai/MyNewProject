//
//  ClassReserveByPhotoLibraryViewController.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/13.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "ClassReserveByPhotoLibraryViewController.h"
#import "PhotoLibraryCollectionViewCell.h"
#import <Photos/Photos.h>

@interface ClassReserveByPhotoLibraryViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UITableView      *tableView;
@property (nonatomic,strong) NSMutableArray<UIImage *>  *photoes;
@property (nonatomic,strong) PHFetchResult<PHAsset *>  *PHFetchResultArray;
@property (nonatomic, strong) PHImageRequestOptions *thumbnailRequestOptions;
@property (nonatomic,strong) PHImageManager *imageManager;


@end

@implementation ClassReserveByPhotoLibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];
    [self initTableView];
    [self initilizeUI];
    [self initThumbnailRequestOptions];
    [self getAllPhoto];
}
- (void)initData {
    _photoes = [NSMutableArray array];
    _PHFetchResultArray = [[PHFetchResult alloc]init];
    _imageManager = [[PHImageManager alloc]init];
}

- (void)getAllPhoto {
    // 所有相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    for (NSInteger i = 0; i < smartAlbums.count; i++) {
        PHCollection *collection = smartAlbums[i];
        //遍历获取相册
        if ([collection isKindOfClass:[PHAssetCollection class]]) {
            
            PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
            
            PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
            
            if (fetchResult.count != 0) {
                
                _PHFetchResultArray = fetchResult;
                
                [_collectionView reloadData];
            }
        }
    }
    
}

- (void)browerPhotoes:(PhotoLibraryCollectionViewCell *)cell index:(NSIndexPath *)index targetSize:(CGSize)targetSize {
    PHAsset *asset = nil;
    
    //从相册中取出照片
    asset = _PHFetchResultArray[index.row];
//    CGFloat scale = [UIScreen mainScreen].scale;
//    CGSize size = CGSizeMake(asset.pixelWidth / scale, asset.pixelHeight / scale);
    
    
//    PHImageManager *imageManager = [[PHImageManager alloc] init];
    
    [_imageManager requestImageForAsset:asset targetSize:targetSize contentMode:PHImageContentModeAspectFill options:_thumbnailRequestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (result) {
            cell.photoImageView.image = result;
        }
    }];
 
}
- (void)initThumbnailRequestOptions
{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    
    _thumbnailRequestOptions = options;
}

- (CGSize)imageSizeForContainerSize:(CGSize)size
{
    CGFloat scale = UIScreen.mainScreen.scale;
    return CGSizeMake(size.width * scale, size.height * scale);
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

- (void)initTableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight) style:(UITableViewStyleGrouped)];
    }
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
//    [_tableView registerClass:[ShareMessageFirstCell class] forCellReuseIdentifier:@"ShareMessageFirstCell"];
}

- (void)initilizeUI {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 300) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor backgroundGrayColorB];
    
//    [self.view addSubview:self.collectionView];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor backgroundGrayColorA];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"PhotoLibraryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PhotoLibraryCollectionViewCell"];
    
    _tableView.tableHeaderView = _collectionView;
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


#pragma mark UICollectionViewDelegate UICollectionViewDatasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _PHFetchResultArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PhotoLibraryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoLibraryCollectionViewCell" forIndexPath:indexPath];
    if (_PHFetchResultArray.count != 0) {
        UICollectionViewLayoutAttributes *attributes =
        [collectionView.collectionViewLayout layoutAttributesForItemAtIndexPath:indexPath];
        
        CGSize targetSize = [self imageSizeForContainerSize:attributes.size];

        [self browerPhotoes:cell index:indexPath targetSize:targetSize];
    }
//    TSWeakSelf
    cell.deletePhotoBlock = ^{
        NSLog(@"%ld",indexPath.row);
    };
    
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
