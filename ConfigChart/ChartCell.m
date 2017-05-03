//
//  ChartCell.m
//  Sinfo
//
//  Created by Sekorm on 2017/4/21.
//  Copyright © 2017年 YeLiang. All rights reserved.
//

#import "ChartCell.h"

@interface ChartCell ()

@property (nonatomic,strong) UILabel *label;
@end

@implementation ChartCell



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self.contentView addSubview:self.label];
        self.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.contentView.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
    }
    return self;
}


- (void)setText:(NSString *)text {
    
    _text = text;
    self.label.text = text;
}

- (UILabel *)label {
    
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.numberOfLines = 0;
        _label.font = [UIFont systemFontOfSize:13];
        _label.textColor = [UIColor lightGrayColor];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.label.frame = self.contentView.bounds;
}

@end
