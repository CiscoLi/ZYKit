//
//  TabBarItem.m
//  ZYKit
//
//  Created by zhaoyang on 2016/12/19.
//  Copyright © 2016年 zhaoyang. All rights reserved.
//

#import "TabBarItem.h"

@interface TabBarItem ()

// 布局
- (void)reLayout;

@end

@implementation TabBarItem

// 设置是否选中
- (void)setSelected:(BOOL)isSelectedNew
{
    if(isSelected != isSelectedNew)
    {
        isSelected = isSelectedNew;
        
        // 刷新
        [self reLayout];
    }
}

// 设置是否禁用
- (void)setDisabled:(BOOL)isDisabledNew
{
    if(isDisabled != isDisabledNew)
    {
        isDisabled = isDisabledNew;
        
        // 禁用控件
        [super setEnabled:!isDisabledNew];
        
        // 刷新
        [self reLayout];
    }
}

- (void)hideShadow:(BOOL)hide
{
    if(isShadowHidden != hide)
    {
        isShadowHidden = hide;
        
        // 刷新
        [self reLayout];
    }
}

// 布局
- (void)reLayout
{
    // 需要重载
}

@end

