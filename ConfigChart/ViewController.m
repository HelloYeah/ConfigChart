//
//  ViewController.m
//  ConfigChart
//
//  Created by Sekorm on 2017/3/17.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Frame.h"
#import "ChartCell.h"
#import "UIView+Frame.h"
#import "ChartTitleView.h"

/***  当前屏幕宽度 */
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
/***  当前屏幕高度 */
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define kPropertyListViewHeight 50
#define kTitleViewWidth 80

@interface ViewController () <UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic)  ChartTitleView *titleView;
@property (strong, nonatomic)  ChartTitleView *propertyListView;
@property (strong, nonatomic)  UIScrollView *contentScrollView;
@property (strong, nonatomic)  NSArray *dataArray;
@property (strong, nonatomic)  UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *propertyWidths;
@property (nonatomic,strong) NSArray *titleHeights;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view addSubview:self.contentScrollView];
    [self.contentScrollView addSubview:self.collectionView];
    [self.collectionView addSubview:self.propertyListView];
    [self.collectionView addSubview:self.titleView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.contentScrollView.contentSize = self.collectionView.bounds.size;
}

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 100;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ChartCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ChartCell" forIndexPath:indexPath];
    cell.text = [NSString stringWithFormat:@"data %ld--%ld",indexPath.section,indexPath.item];
    return cell;
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat width = [self.propertyWidths[indexPath.item] floatValue];
    CGFloat height = [self.titleHeights[indexPath.section] floatValue];
    return CGSizeMake(width, height);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.contentScrollView) {
        
        if (self.contentScrollView.contentOffset.x > 0) {
            self.titleView.left = self.contentScrollView.contentOffset.x;
        }else {
            self.titleView.left = 0;
        }
        
    }else if(scrollView == self.collectionView) {
        
        if (self.collectionView.contentOffset.y > 0) {
            self.titleView.topTitleView.top = self.collectionView.contentOffset.y;
        }else {
            self.titleView.topTitleView.top = 0;
        }
        
        if (self.collectionView.contentOffset.y > 0) {
            self.propertyListView.top =  scrollView.contentOffset.y;
        }else {
            self.propertyListView.top = 0;
        }
    }
}


- (UICollectionView *)collectionView {
    
    if  (!_collectionView) {
        
        UICollectionViewFlowLayout *selectChartLayout = [[UICollectionViewFlowLayout alloc] init];
        selectChartLayout.minimumLineSpacing = 0;
        selectChartLayout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.propertyListView.width, SCREEN_HEIGHT) collectionViewLayout:selectChartLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[ChartCell class] forCellWithReuseIdentifier:@"ChartCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (UIScrollView *)contentScrollView {
    
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        [_contentScrollView addSubview:self.collectionView];
        _contentScrollView.delegate = self;
    }
    return _contentScrollView;
}


- (NSArray *)propertyWidths {
    
    if (!_propertyWidths) {
        NSMutableArray *widthsArray = [NSMutableArray array];
        for ( NSInteger i = 0; i < 10; i ++) {
            if (i == 0) {
                
                [widthsArray addObject:@(kTitleViewWidth)];
                continue;
            }
            [widthsArray addObject:@(100 + rand() % 50)];
        }
        _propertyWidths = [widthsArray copy];
    }
    return _propertyWidths;
}


- (NSArray *)titleHeights {

    if (!_titleHeights) {
        NSMutableArray *heightsArray = [NSMutableArray array];
        for ( NSInteger i = 0; i < 100; i ++) {
            if (i == 0) {
                [heightsArray addObject:@(kPropertyListViewHeight)];
                continue;
            }
            [heightsArray addObject:@(35 + rand() % 20)];
        }
        _titleHeights = [heightsArray copy];
    }
    return _titleHeights;
}


- (ChartTitleView *)titleView {
    
    if (!_titleView) {
        
        _titleView = [[ChartTitleView  alloc] initWithFrame:CGRectMake(0, 0, kTitleViewWidth, 0)];
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for ( NSInteger i = 0; i < 100; i ++) {
            [tempArray addObject:[NSString stringWithFormat:@"title %02ld",i]];
        }
        [_titleView setTitles:tempArray andWidths:self.titleHeights andLayoutDirection:LayoutVertical];
    }
    return _titleView;
}

- (ChartTitleView *)propertyListView {
    
    if (!_propertyListView) {
        
        _propertyListView = [[ChartTitleView  alloc] initWithFrame:CGRectMake(0, 0, 0, kPropertyListViewHeight)];
        NSMutableArray *tempArray = [NSMutableArray array];
        for ( NSInteger i = 0; i < 10; i ++) {
            [tempArray addObject:[NSString stringWithFormat:@"property %02ld",i]];
        }
        [_propertyListView setTitles:tempArray andWidths:self.propertyWidths andLayoutDirection:LayoutHorizontal];
    }
    return _propertyListView;
}

#pragma mark - 旋转
- (BOOL)shouldAutorotate
{
    return YES;
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    self.contentScrollView.width = SCREEN_WIDTH;
    self.contentScrollView.height = SCREEN_HEIGHT;
    self.collectionView.height = self.contentScrollView.height;
    //self.collectionView.width = self.propertyListView.width;
    self.contentScrollView.contentSize = self.collectionView.size;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}

@end
