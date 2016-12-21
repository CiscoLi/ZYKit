//
//  LineView.h
//  ZYKit
//
//  Created by zhaoyang on 2016/12/21.
//  Copyright © 2016年 zhaoyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineView : UIView

@property (nonatomic, assign) BOOL isDotted;		// 是否为虚线
@property (nonatomic, assign) BOOL isVertical;		// 是否为竖线
@property (nonatomic, strong) NSArray *arrayColor;	// 颜色Array

// 创建
- (id)init;
- (id)initWithFrame:(CGRect)frameInit;
- (id)initDottedWithFrame:(CGRect)frameInit;

// 重新设置Frame
- (void)setFrame:(CGRect)frame;

@end
