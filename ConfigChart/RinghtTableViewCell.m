//
//  RinghtTableViewCell.m
//  ConfigChart
//
//  Created by Sekorm on 2017/3/21.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "RinghtTableViewCell.h"
#import "UIView+Frame.h"

@implementation RinghtTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    
    for (int i = 0; i < 9; i ++) {
        UIButton *btn = [[UIButton alloc] init];
        //btn.backgroundColor = [UIColor lightGrayColor];
        btn.layer.borderWidth = 0.5;
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.contentView addSubview:btn];
        NSInteger randText = rand() % 10000;
        [btn setTitle:[NSString stringWithFormat:@"%04ld",randText] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat width = self.width / 9;
    for (int i = 0; i < 9; i ++) {
        UIButton *line = self.contentView.subviews[i];
        CGFloat x = width * i ;
        line.frame = CGRectMake(x, 0, width, self.height);
    }
}

@end
