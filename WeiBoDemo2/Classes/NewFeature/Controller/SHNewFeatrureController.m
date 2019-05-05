//
//  SHNewFeatrureController.m
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/5.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import "SHNewFeatrureController.h"

#import "SHNewFeatureCell.h"

@interface SHNewFeatrureController ()

@property (nonatomic,weak) UIPageControl *pageControl;

@end

@implementation SHNewFeatrureController

static NSString * const reuseIdentifier = @"Cell";

// 重写init方法
- (instancetype)init {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[SHNewFeatureCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    // 设置pageController
    [self setupPageController];
}

- (void)setupPageController {
    
    UIPageControl *pgControl = [UIPageControl new];
    
    pgControl.numberOfPages = 4;
    pgControl.pageIndicatorTintColor = [UIColor blackColor];
    pgControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    pgControl.center = CGPointMake(self.view.bounds.size.width / 2,self.view.bounds.size.height - 40);
    _pageControl = pgControl;
    [self.view addSubview:pgControl];
}

#pragma mark - ScorllViewDelege

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int pageNumber = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    _pageControl.currentPage = pageNumber;
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SHNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld-568h@2x",indexPath.row + 1];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@".png"];
    
    cell.image = [UIImage imageWithContentsOfFile:filePath];    // 据说通过文件加载的图片，无缓存 实际运行ram:57.6M
    //cell.image = [UIImage imageNamed:imageName];    // 实际运行ram:60.8M
    
    [cell setIndexPath:indexPath count:4];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
