//
//  ViewController.m
//  ConfigChart
//
//  Created by Sekorm on 2017/3/17.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 84;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * const ID = @"Identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle: UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (tableView == self.tableView) {
        cell.textLabel.text = [NSString stringWithFormat:@"型号+%ld",indexPath.row];

    }else {
        cell.textLabel.text = [NSString stringWithFormat:@"参数+%02ld | 参数+%02ld | 参数+%02ld | 参数+%02ld | 参数+%02ld | 参数+%02ld |",indexPath.row,indexPath.row,indexPath.row,indexPath.row,indexPath.row,indexPath.row];
    }
        if (indexPath.row % 2) {
        cell.backgroundColor = [UIColor cyanColor];
    }else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
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
