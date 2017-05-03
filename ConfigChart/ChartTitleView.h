//
//  SKElementSelectTitleView.h
//  Sinfo
//
//  Created by Sekorm on 2017/4/21.
//  Copyright © 2017年 YeLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LayoutVertical,
    LayoutHorizontal,
} LayoutDirection;

@interface ChartTitleView : UIView

@property (nonatomic,strong) UIView *topTitleView;

- (void)setTitles:(NSArray *)titles andWidths:(NSArray *)widths andLayoutDirection:(LayoutDirection)layoutDirection;

@end
