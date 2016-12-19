//
//  TabBarItem.h
//  ZYKit
//
//  Created by zhaoyang on 2016/12/19.
//  Copyright © 2016年 zhaoyang. All rights reserved.
//

#import <UIKit/UIKit.h>

// 需要重载的接口(因为交叉引用的关系，拿出来放在单独的文件中)
@protocol TabBarItemPtc <NSObject>

- (CGSize)perfectSize;						// 获取最佳Size
- (void)setFrame:(CGRect)frameNew;			// 设置Frame
- (void)setSelected:(BOOL)isSelected;		// 设置选中

@optional

- (void)setIsLast:(NSNumber *)isLastNew;	// 是否为最后一个

@end


// 基类
@interface TabBarItem : UIControl
{
    BOOL isSelected;				// 是否选中
    BOOL isDisabled;				// 是否禁用
    BOOL isShadowHidden;            // 阴影是否被隐藏
}

// 类型定义index   注：用于自定义的索引
@property (nonatomic) NSInteger typeDefIndex;
// 创建index
@property (nonatomic) NSInteger createIndex;

// 设置属性
- (void)setDisabled:(BOOL)isDisabledNew;
- (void)hideShadow:(BOOL)hide;

@end
