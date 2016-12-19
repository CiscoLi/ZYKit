//
//  TabBar.h
//  ZYKit
//
//  Created by zhaoyang on 2016/12/19.
//  Copyright © 2016年 zhaoyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import	"TabBarItem.h"

@class TabBar;

// TabBar协议
@protocol TabBarPtc <NSObject>

- (void)tabBar:(TabBar *)tabBar didSelectItem:(TabBarItem *)item withIndex:(NSInteger)currentIndex;

@end

// TabBar
@interface TabBar : UIView

// 初始化
- (id)initWithFrame:(CGRect)frameInit canScroll:(BOOL)scrollable;
- (id)initWhiteWithFrame:(CGRect)frameInit canScroll:(BOOL)scrollable;

// 设置Frame
- (void)setFrame:(CGRect)frameNew;

// 设置背景图片
- (void)setBackgroundImage:(UIImage *)imageBG;

// 添加item
- (void)appendItem:(TabBarItem<TabBarItemPtc> *)item;
- (void)insertItem:(TabBarItem<TabBarItemPtc> *)item atIndex:(NSUInteger)index;

// 删除Item
- (void)removeItemAtIndex:(NSUInteger)index;
- (void)removeAllItems;

// Item
- (TabBarItem *)itemAtIndex:(NSUInteger)index;
- (TabBarItem *)itemAtTypeDefIndex:(NSUInteger)typeDefIndex;

// 选中项
- (NSInteger)selectedItemOldIndex;
- (NSInteger)selectedItemIndex;
- (void)setSelectedItemIndex:(NSInteger)index;


// 设置代理
- (void)setDelegate:(id<TabBarPtc>)delegateNew;

@end
