//
//  PageView.h
//  ZYKit
//
//  Created by zhaoyang on 2016/12/15.
//  Copyright © 2016年 zhaoyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PageViewDelegate <NSObject>

@optional
/**
 *  代理方法(选择了第几张图片)
 *
 *  @param selectNumber 选中第几张
 */
- (void)didSelectPageViewWithNumber:(NSInteger)selectNumber;

@end


@interface PageView : UIView
/**
 *  放图片的数组
 */
@property (nonatomic, strong) NSArray * imageArray;
/**
 *  图片的运行时间
 */
@property (nonatomic ,assign) NSTimeInterval duration;
/**
 *  是否是网络图片
 */
@property (nonatomic ,assign) BOOL isWebImage;
/**
 *  是否要变成第一张图片
 */
@property (nonatomic, assign) BOOL isFirstImage;
/**
 *  初始化方法
 *
 *  @param frame pageview的frame
 *
 *  @return 本身
 */
-(instancetype)initPageViewFrame:(CGRect)frame;
/**
 *  pageview的代理方法
 */
@property (nonatomic ,weak) id<PageViewDelegate> delegate;

@end
