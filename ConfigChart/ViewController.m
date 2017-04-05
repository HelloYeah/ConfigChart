//
//  ViewController.m
//  ConfigChart
//
//  Created by Sekorm on 2017/3/17.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "ViewController.h"
#import "RinghtTableViewCell.h"
#import "UIView+Frame.h"

@interface ViewController () <UITableViewDataSource,UIScrollViewDelegate,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.layer.borderWidth = 0.5;
    self.tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.rightTableView.allowsSelection = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 84;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView == self.tableView) {
        NSString * const ID = @"Identifier";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle: UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.layoutMargins = UIEdgeInsetsZero;
            cell.separatorInset = UIEdgeInsetsZero;
        }
        cell.textLabel.text = [NSString stringWithFormat:@"型号_%02ld",indexPath.row];
        return cell;

    }else {
        NSString * const ID = @"RinghtTableViewCell";
        RinghtTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (!cell) {
            cell = [[RinghtTableViewCell alloc]initWithStyle: UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.layoutMargins = UIEdgeInsetsZero;
            cell.separatorInset = UIEdgeInsetsZero;
        }
        return cell;

    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (tableView == self.tableView) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 35)];
        label.text = @"型号";
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor orangeColor];
        return label;
    }
    
    UIView *sectionHeader = [[UIView alloc] init];
    sectionHeader.width = self.rightTableView.width;
    CGFloat btnW = sectionHeader.width / 9.0;
    for (int i = 0; i < 9; i ++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.backgroundColor = [UIColor orangeColor];
        btn.layer.borderWidth = 0.5;
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [sectionHeader addSubview:btn];
        NSInteger randText = rand() % 1000;
        [btn setTitle:[NSString stringWithFormat:@"参数_%ld",randText] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(i * btnW, 0, btnW, 35);
    }

    return sectionHeader;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.tableView) {
        
        CGFloat offsetY = self.tableView.contentOffset.y;
        CGPoint offset = self.rightTableView.contentOffset;
        self.rightTableView.contentOffset = CGPointMake(offset.x, offsetY);
    }
    if (scrollView == self.rightTableView) {
        
        CGFloat offsetY = self.rightTableView.contentOffset.y;
        CGPoint offset = self.tableView.contentOffset;
        self.tableView.contentOffset = CGPointMake(offset.x, offsetY);
    }
}


@end
