//
//  ViewController.m
//  ConfigChart
//
//  Created by Sekorm on 2017/3/17.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Frame.h"

@interface ViewController () <UITableViewDataSource,UIScrollViewDelegate,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;


@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.tableView.layer.borderWidth = 0.5;
    self.tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.rightTableView.allowsSelection = NO;
}

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * const ID = @"Identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle: UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.separatorInset = UIEdgeInsetsZero;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"型号_%02ld",indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 35)];
    label.text = @"型号";
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor orangeColor];
    return label;
    
//    UIView *sectionHeader = [[UIView alloc] init];
//    sectionHeader.width = self.collectionView.width;
//    CGFloat btnW = sectionHeader.width / 9.0;
//    for (int i = 0; i < 9; i ++) {
//        UIButton *btn = [[UIButton alloc] init];
//        btn.backgroundColor = [UIColor orangeColor];
//        btn.layer.borderWidth = 0.5;
//        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        [sectionHeader addSubview:btn];
//        NSInteger randText = rand() % 1000;
//        [btn setTitle:[NSString stringWithFormat:@"参数_%ld",randText] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        btn.frame = CGRectMake(i * btnW, 0, btnW, 35);
//    }
//
//    return sectionHeader;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 35;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 80;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionReuseIdentifier" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:0.4];

    return cell;
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//
//    UICollectionReusableView *collectionReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionReusableView" forIndexPath:indexPath];
//    return collectionReusableView;
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.tableView) {
        
        CGFloat offsetY = self.tableView.contentOffset.y;
        CGPoint offset = self.collectionView.contentOffset;
        self.collectionView.contentOffset = CGPointMake(offset.x, offsetY);
    }
    if (scrollView == self.collectionView) {
        
        CGFloat offsetY = self.collectionView.contentOffset.y;
        CGPoint offset = self.tableView.contentOffset;
        self.tableView.contentOffset = CGPointMake(offset.x, offsetY);
        
    }
    
    if (scrollView.contentOffset.y < 0) {
        self.stackView.top = - scrollView.contentOffset.y;
    }
}


@end
