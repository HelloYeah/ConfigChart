//
//  SKElementSelectTitleView.m
//  Sinfo
//
//  Created by Sekorm on 2017/4/21.
//  Copyright © 2017年 YeLiang. All rights reserved.
//

#import "ChartTitleView.h"
#import "UIView+Frame.h"

@interface ChartTitleView ()
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) NSArray *widths;
@property (nonatomic,strong) NSMutableArray *titleViews;
@property (nonatomic,assign) LayoutDirection layoutDirection;
@end

@implementation ChartTitleView


- (void)setTitles:(NSArray *)titles andWidths:(NSArray *)widths {
    
    _titles = titles;
    _widths = widths;
    
    NSAssert(_titles.count == _widths.count, @"titles.count must equal widths.count");
    
    for (UIView *view in self.titleViews) {
        [view removeFromSuperview];
    }
    [self.titleViews removeAllObjects];
    
    for (int i = 0; i < _titles.count; i++) {
        
        UILabel *label = [self titleLabelWithBorderColor:[UIColor lightGrayColor]];
        if (i == 0) {
            self.topTitleView = label;
        }
        label.text = _titles[i];
        
        [self addSubview:label];
        [self.titleViews addObject:label];
    }
    [self bringSubviewToFront:self.topTitleView];
}


- (void)setTitles:(NSArray *)titles andWidths:(NSArray *)widths andLayoutDirection:(LayoutDirection)layoutDirection {
    
    [self setTitles:titles andWidths:widths];
    self.layoutDirection = layoutDirection;
    [self layoutSubviewsWithDirection];
}

- (UILabel *)titleLabelWithBorderColor:(UIColor *)color {
    
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.borderColor = color.CGColor;
    label.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:13];
    label.backgroundColor = [UIColor whiteColor];
    return label;
}

- (NSMutableArray *)titleViews {
    
    if (!_titleViews) {
        _titleViews = [NSMutableArray array];
    }
    return _titleViews;
}



- (void) layoutSubviewsWithDirection {
    
    if (self.layoutDirection == LayoutVertical) {
        
        CGFloat titleViewHeight = 0;
        for (int i = 0; i < self.titleViews.count; i++) {
            
            UILabel *label = self.titleViews[i];
            NSNumber *widthNumber = _widths[i];
            label.size = CGSizeMake(self.width, widthNumber.floatValue);
            label.top = titleViewHeight;
            titleViewHeight += widthNumber.floatValue;
        }
        self.height = titleViewHeight;
        
    }else {
        
        CGFloat titleViewWidth = 0;
        for (int i = 0; i < self.titleViews.count; i++) {
            
            UILabel *label = self.titleViews[i];
            NSNumber *widthNumber = _widths[i];
            label.size = CGSizeMake(widthNumber.floatValue,self.height);
            label.left = titleViewWidth;
            titleViewWidth += widthNumber.floatValue;
        }
        self.width = titleViewWidth;
    }
}

@end
