//
//  TabBar.m
//  ZYKit
//
//  Created by zhaoyang on 2016/12/19.
//  Copyright © 2016年 zhaoyang. All rights reserved.
//

#import "TabBar.h"

typedef enum
{
    eTabBarTypeNone = 1,		// 无类型
    eTabBarTypeWhite,
    eTabBarTypeSmall,
} TabBarType;
// ==================================================================
// 尺寸
// ==================================================================
#define kTabBarWhiteHeight							51
#define kTabBarBlackHeight                          51
#define kTabBarSmallHeight							45
#define kTabBarLargeHeight							51

@interface TabBar ()

@property (nonatomic, strong) UIImageView *imageViewBG;			// 背景图片
@property (nonatomic, strong) UIScrollView *scrollView;			// 滚动栏
@property (nonatomic, strong) NSMutableArray *arrayTabBarItem;	// Item
@property (nonatomic, assign) NSInteger selectedIndex;			// 当前选中项
@property (nonatomic, assign) NSInteger selectedOldIndex;       // 之前选中项
@property (nonatomic, assign) BOOL isScrollable;				// 是否可以滚动
@property (nonatomic, assign) TabBarType tabType;				// 类型
@property (nonatomic, assign) id<TabBarPtc> delegate;			// 代理

// 调整Item的Frame
- (void)reLayoutItemFrame;

// Item选择事件
- (void)itemSelected:(id)sender;

@end


// ==================================================================
// 实现
// ==================================================================
@implementation TabBar

- (id)initWithFrame:(CGRect)frameInit canScroll:(BOOL)scrollable
{
    if((self = [super initWithFrame:frameInit]) != nil)
    {
        // imageView
        _imageViewBG = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_imageViewBG];
        
        // ScrollView
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [_scrollView setClipsToBounds:NO];
        [self addSubview:_scrollView];
        
        // 设置选项
        _selectedIndex = -1;
        
        // 不可滚动
        _isScrollable = scrollable;
        
        // 设置Item数组
        _arrayTabBarItem = [[NSMutableArray alloc] initWithCapacity:0];
        
        // 类型
        _tabType = eTabBarTypeNone;
        
        if(_isScrollable)
        {
            [_scrollView setClipsToBounds:YES];
        }
        
        return self;
    }
    
    return nil;
}

- (id)initWhiteWithFrame:(CGRect)frameInit canScroll:(BOOL)scrollable
{
    if((self = [self initWithFrame:CGRectMake(frameInit.origin.x, frameInit.origin.y, frameInit.size.width, kTabBarWhiteHeight) canScroll:scrollable]) != nil)
    {
        _tabType = eTabBarTypeWhite;
        
        return self;
    }
    
    return nil;
}

- (id)initSmallWithFrame:(CGRect)frameInit canScroll:(BOOL)scrollable
{
    if((self = [self initWithFrame:CGRectMake(frameInit.origin.x, frameInit.origin.y, frameInit.size.width, kTabBarSmallHeight) canScroll:scrollable]) != nil)
    {
        _tabType = eTabBarTypeSmall;
        
        return self;
    }
    
    return nil;
}


// 设置Frame
- (void)setFrame:(CGRect)frameNew
{
    if(_tabType == eTabBarTypeSmall)
    {
        [super setFrame:CGRectMake(frameNew.origin.x, frameNew.origin.y, frameNew.size.width, kTabBarSmallHeight)];
    }
    else if(_tabType == eTabBarTypeWhite)
    {
        [super setFrame:CGRectMake(frameNew.origin.x, frameNew.origin.y, frameNew.size.width, kTabBarWhiteHeight)];
    }
    else
    {
        [super setFrame:frameNew];
    }
    
    // 刷新
    [self reLayoutItemFrame];
}

// 设置背景图片
- (void)setBackgroundImage:(UIImage *)imageBG
{
    [_imageViewBG setImage:imageBG];
}

// 添加item
- (void)appendItem:(TabBarItem<TabBarItemPtc> *)item
{
    NSUInteger itemCount = [_arrayTabBarItem count];
    [self insertItem:item atIndex:itemCount];
}

- (void)insertItem:(TabBarItem<TabBarItemPtc> *)item atIndex:(NSUInteger)index
{
    // 获取Item的数目
    NSUInteger itemCount = [_arrayTabBarItem count];
    if(index <= itemCount)
    {
        // 创建新的Button
        [item addTarget:self action:@selector(itemSelected:) forControlEvents:UIControlEventTouchDown];
        [item setSelected:NO];
        
        // 保存
        [_arrayTabBarItem insertObject:item atIndex:index];
        [_scrollView addSubview:item];
        
        // 调整
        [self reLayoutItemFrame];
        
        // 调整选中状态
        if((_selectedIndex != -1) && (index <= _selectedIndex))
        {
            NSInteger itemCountNew = [_arrayTabBarItem count];
            
            // 旧的选中的
            NSInteger selectedIndexOld = _selectedIndex + 1;
            if(selectedIndexOld < itemCountNew)
            {
                TabBarItem *itemSelectedOld = [_arrayTabBarItem objectAtIndex:selectedIndexOld];
                [itemSelectedOld setSelected:NO];
            }
            
            // 当前选中的
            if(_selectedIndex < itemCountNew)
            {
                TabBarItem *itemSelected = [_arrayTabBarItem objectAtIndex:_selectedIndex];
                [itemSelected setSelected:YES];
            }
        }
    }
}

// 删除Item
- (void)removeItemAtIndex:(NSUInteger)index
{
    NSInteger itemCount = [_arrayTabBarItem count];
    if(index < itemCount)
    {
        // 删除Item
        TabBarItem *item = [_arrayTabBarItem objectAtIndex:index];
        [item removeFromSuperview];
        [_arrayTabBarItem removeObjectAtIndex:index];
        
        // 调整
        [self reLayoutItemFrame];
    }
    
    // 设置新的选中项
    NSInteger segmentCountNew = [_arrayTabBarItem count];
    if(_selectedIndex >= segmentCountNew)
    {
        _selectedIndex = -1;
    }
    else
    {
        TabBarItem *itemNew = [_arrayTabBarItem objectAtIndex:_selectedIndex];
        [itemNew setSelected:YES];
    }
}

- (void)removeAllItems
{
    // 删除Item
    NSInteger itemCount = [_arrayTabBarItem count];
    for(NSInteger i = 0; i < itemCount; i++)
    {
        TabBarItem *item = [_arrayTabBarItem objectAtIndex:i];
        [item removeFromSuperview];
    }
    
    [_arrayTabBarItem removeAllObjects];
    _selectedIndex = -1;
}

// Item
- (TabBarItem *)itemAtIndex:(NSUInteger)index
{
    NSUInteger itemCount = [_arrayTabBarItem count];
    if(index < itemCount)
    {
        return [_arrayTabBarItem objectAtIndex:index];
    }
    
    return nil;
}

// 根据类型索引获取item
- (TabBarItem *)itemAtTypeDefIndex:(NSUInteger)typeDefIndex
{
    for (NSInteger i=0; i<[_arrayTabBarItem count]; i++)
    {
        TabBarItem *currItem = [_arrayTabBarItem objectAtIndex:i];
        if (currItem != nil)
        {
            if (currItem.typeDefIndex == typeDefIndex)
            {
                return currItem;
            }
        }
    }
    
    return nil;
}

// 选中项
- (NSInteger)selectedItemIndex
{
    return _selectedIndex;
}

// 之前选中项
- (NSInteger)selectedItemOldIndex
{
    return _selectedOldIndex;
}

- (void)setSelectedItemIndex:(NSInteger)index
{
    if(index != _selectedIndex)
    {
        NSInteger itemCount = [_arrayTabBarItem count];
        if(index < itemCount)
        {
            // 去掉旧的选中项
            if((_selectedIndex != -1) && (_selectedIndex < itemCount))
            {
                TabBarItem *item = [_arrayTabBarItem objectAtIndex:_selectedIndex];
                [item setSelected:NO];
            }
            
            // 选中新的项
            if(index != -1)
            {
                TabBarItem *itemSelected = [_arrayTabBarItem objectAtIndex:index];
                [itemSelected setSelected:YES];
                
                // 如果可以移动，调整Item位置到一个合适的位置
                if(_isScrollable)
                {
                    NSInteger itemXStart = 0;
                    NSInteger itemXEnd = 0;
                    for(NSInteger i = 0; i < itemCount; i++)
                    {
                        TabBarItem *item = [_arrayTabBarItem objectAtIndex:i];
                        CGRect itemFrame = [item frame];
                        
                        // 选中Item之前的Item
                        if(i < index)
                        {
                            // 累积宽度
                            itemXStart += itemFrame.size.width;
                        }
                        else
                        {
                            itemXEnd = itemXStart + itemFrame.size.width;
                            break;
                        }
                    }
                    
                    CGPoint contentOffset = [_scrollView contentOffset];
                    CGSize scrollSize = [_scrollView frame].size;
                    
                    // 调整开始位置
                    if(contentOffset.x > itemXStart)
                    {
                        [_scrollView setContentOffset:CGPointMake(itemXStart, 0) animated:YES];
                    }
                    else if((contentOffset.x + scrollSize.width) < itemXEnd)
                    {
                        [_scrollView setContentOffset:CGPointMake(itemXEnd - scrollSize.width, 0) animated:YES];
                    }
                }
            }
            
            // 修改选中项
            _selectedIndex = index;
        }
    }
}

// 调整Item的Frame
- (void)reLayoutItemFrame
{
    // 父窗口属性
    CGRect parentFrame = [self frame];
    
    // 游标
    NSInteger spaceX = 0;
    NSInteger itemsPerfectWidth = 0;
    NSInteger homeItemCount = 0;
    NSInteger homeItemsWidth = 0;
    
    // 背景
    if(_imageViewBG != nil)
    {
        if(_tabType == eTabBarTypeSmall)
        {
            [_imageViewBG setImage:[UIImage imageNamed:@""]];
        }
        else if(_tabType == eTabBarTypeWhite)
        {
            [_imageViewBG setImage:[UIImage imageNamed:@"bg_tabbarbgwhite.png"]];
        }
        
        [_imageViewBG setFrame:CGRectMake(0, 0, parentFrame.size.width, parentFrame.size.height)];
    }
    
    // 统计
    NSInteger itemCount = [_arrayTabBarItem count];
    for(NSInteger i = 0; i < itemCount; i++)
    {
        TabBarItem *item = [_arrayTabBarItem objectAtIndex:i];
        
        // 统计宽度
        if(_isScrollable)
        {
            if([item conformsToProtocol:@protocol(TabBarItemPtc)])
            {
                itemsPerfectWidth += [(TabBarItem<TabBarItemPtc> *)item perfectSize].width;
            }
        }
    }
    
    // 需要滚动
    if(itemsPerfectWidth > parentFrame.size.width)
    {
        // 设置Item Frame
        NSInteger itemCount = [_arrayTabBarItem count];
        for(NSInteger i = 0; i < itemCount; i++)
        {
            TabBarItem *item = [_arrayTabBarItem objectAtIndex:i];
            
            // 设置最后一项属性
            if([item respondsToSelector:@selector(setIsLast:)] == YES)
            {
                if(i != (itemCount - 1))
                {
                    NSNumber *isLast = [[NSNumber alloc] initWithBool:NO];
                    [item performSelector:@selector(setIsLast:) withObject:isLast];
                }
                else
                {
                    NSNumber *isLast = [[NSNumber alloc] initWithBool:YES];
                    [item performSelector:@selector(setIsLast:) withObject:isLast];
                }
            }
            
            // 得到最佳宽度
            NSInteger perfectWidth = 0;
            if([item conformsToProtocol:@protocol(TabBarItemPtc)])
            {
                perfectWidth = [(TabBarItem<TabBarItemPtc> *)item perfectSize].width;
            }
            
            // 调整Frame
            [item setFrame:CGRectMake(spaceX, 0, perfectWidth, parentFrame.size.height)];
            
            // 调整游标
            spaceX += [item frame].size.width;
        }
        
        // 设置ScrollBar的Frame
        if(_scrollView != nil)
        {
            [_scrollView setFrame:CGRectMake(0, 0, parentFrame.size.width, parentFrame.size.height)];
            [_scrollView setContentSize:CGSizeMake(spaceX, parentFrame.size.height)];
        }
    }
    else
    {
        // 计算尺寸
        NSInteger itemCount = [_arrayTabBarItem count];
        NSInteger normalItemCount = itemCount - homeItemCount;
        NSInteger itemWidth = 0;
        if(normalItemCount != 0)
        {
            itemWidth = (parentFrame.size.width - homeItemsWidth) / normalItemCount;
        }
        
        // 遍历
        for(NSInteger i = 0; i < itemCount; i++)
        {
            TabBarItem *item = [_arrayTabBarItem objectAtIndex:i];
            
            // 设置最后一项属性
            if([item respondsToSelector:@selector(setIsLast:)] == YES)
            {
                if(i != (itemCount - 1))
                {
                    NSNumber *isLast = [[NSNumber alloc] initWithBool:NO];
                    [item performSelector:@selector(setIsLast:) withObject:isLast];
                }
                else
                {
                    NSNumber *isLast = [[NSNumber alloc] initWithBool:YES];
                    [item performSelector:@selector(setIsLast:) withObject:isLast];
                }
            }
            
            //            // white Item
            //            if([item isKindOfClass:[TabBarWhiteItem class]])
            //            {
            //                [item setFrame:CGRectMake(spaceX, 0, [item frame].size.width, parentFrame.size.height)];
            //            }
            //            else
            //            {
            if(i != (itemCount - 1))
            {
                [item setFrame:CGRectMake(spaceX, 0, itemWidth, parentFrame.size.height)];
            }
            else
            {
                [item setFrame:CGRectMake(spaceX, 0, parentFrame.size.width - spaceX, parentFrame.size.height)];
            }
            //            }
            
            // 调整游标
            spaceX += [item frame].size.width;
        }
        
        // 设置ScrollBar的Frame
        if(_scrollView != nil)
        {
            [_scrollView setFrame:CGRectMake(0, 0, parentFrame.size.width, parentFrame.size.height)];
            [_scrollView setContentSize:CGSizeMake(parentFrame.size.width, parentFrame.size.height)];
        }
    }
}

// Item选择事件
- (void)itemSelected:(id)sender
{
    
    TabBarItem *item = (TabBarItem *)sender;
    
    // 查找Item
    NSInteger itemCount = [_arrayTabBarItem count];
    for(NSInteger i = 0; i < itemCount; i++)
    {
        TabBarItem *itemCur = [_arrayTabBarItem objectAtIndex:i];
        if(itemCur == item)
        {
            // 保存之前选中项
            _selectedOldIndex = _selectedIndex;
            
            // 设置新的选中索引值
            [self setSelectedItemIndex:i];
            
            
            // 触发代理
            if((_delegate != nil) && ([_delegate conformsToProtocol:@protocol(TabBarPtc)]))
            {
                [_delegate tabBar:self didSelectItem:item withIndex:i];
            }
            
            break;
        }
    }
}

// 设置代理
- (void)setDelegate:(id<TabBarPtc>)delegateNew
{
    _delegate = delegateNew;
}

// 销毁代理
- (void)dealloc
{
    _delegate = nil;
}

@end
