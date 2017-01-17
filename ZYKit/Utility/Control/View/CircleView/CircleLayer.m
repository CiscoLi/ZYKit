//
//  CircleLayer.m
//  ZYKit
//
//  Created by zhaoyang on 2017/1/16.
//  Copyright © 2017年 zhaoyang. All rights reserved.
//

#import "CircleLayer.h"
#import <UIKit/UIKit.h>

// 枚举:是B点或者D点 移动
typedef enum MovingPoint{
    POINT_D,
    POINT_B,
} MovingPoint;

// 外接框尺寸
#define outsideRectSize                     90


@interface CircleLayer()

@property (nonatomic,assign)CGRect outsideRect;

// 记录上次的progress,方便求差值得出来滑动方向
@property (nonatomic,assign) CGFloat lastProgress;

//实时的记录滑动方向
@property (nonatomic,assign) MovingPoint movePoint;


@end

@implementation CircleLayer

//初始化方法
- (instancetype)init{
    if (self  = [super init]) {
        self.lastProgress = 0.5;
    }
    return self;
}

//通过一个layer创建一个副本
- (instancetype)initWithLayer:(CircleLayer *)layer
{
    if (self = [super initWithLayer:layer]) {
        self.progress = layer.progress;
        self.outsideRect = layer.outsideRect;
        self.lastProgress = layer.lastProgress;
    }
    return self;
}

//ctx的字面意思是上下文.就是一块画布,也就是说,一旦在某个地方改了画布的一些属性,其他任何使用画布的属性的时候都是改了之后的.
- (void)drawInContext:(CGContextRef)ctx
{
    //A-C1,B-C2...的距离.当设置为正方形边长的1/3.6倍时,画出来的圆弧完美贴合圆形.
    //目的:确定C1....C8的点. 方便以后计算
    CGFloat offset = self.outsideRect.size.width / 3.6;
    
    //ABCD实际需要移动的距离,系数为滑块偏离中点0.5的绝对值乘以2,当滑到两端的时候,movedDistance为最大值,为外接矩形宽度的1/5
    CGFloat movedDistance = (self.outsideRect.size.width * 1/5) * fabs(self.progress - 0.5) * 2;
    
    //为了方便各个点计算左边.先算出外接矩形的中心点坐标
    CGPoint rectCenter = CGPointMake(self.outsideRect.origin.x + self.outsideRect.size.width / 2, self.outsideRect.origin.y + self.outsideRect.size.height / 2);
    
    //开始计算各个点的坐标(不能计算初始化的默认值, 应该是通过movedDistance去动态计算)
    CGPoint pointA = CGPointMake(rectCenter.x, self.outsideRect.origin.y + movedDistance);
    CGPoint pointB = CGPointMake(self.movePoint == POINT_D ? rectCenter.x + self.outsideRect.size.width/2 : rectCenter.x + self.outsideRect.size.width / 2 + movedDistance * 2 , rectCenter.y);
    CGPoint pointC = CGPointMake(rectCenter.x, self.outsideRect.origin.y - movedDistance);
    CGPoint pointD = CGPointMake(self.movePoint == POINT_D ? self.outsideRect.origin.x - movedDistance * 2 : self.outsideRect.origin.x, rectCenter.y);
    
    //开始计算C1到C8的坐标
    CGPoint c1 = CGPointMake(pointA.x + offset, pointA.y);
    CGPoint c2 = CGPointMake(pointB.x, self.movePoint == POINT_D ? pointB.y - offset : pointB.y - offset + movedDistance);
    CGPoint c3 = CGPointMake(pointB.x, self.movePoint == POINT_D ? pointB.y + offset : pointB.y + offset - movedDistance);
    CGPoint c4 = CGPointMake(pointC.x + offset, pointC.y);
    
    CGPoint c5 = CGPointMake(pointC.x - offset, pointC.y);
    CGPoint c6 = CGPointMake(pointD.x, self.movePoint == POINT_D ? pointD.y + offset - movedDistance : pointD.y + offset);
    
    CGPoint c7 = CGPointMake(pointD.x, self.movePoint == POINT_D ? pointD.y - offset + movedDistance : pointD.y - offset);
    CGPoint c8 = CGPointMake(pointA.x - offset, pointA.y);
    
    // 外接虚线矩形
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:self.outsideRect];
    CGContextAddPath(ctx, rectPath.CGPath);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(ctx, 1.0);
    CGFloat dash[] = {5.0,5.0};
    CGContextSetLineDash(ctx, 0.0, dash,2);//1
    CGContextStrokePath(ctx);//给线条填充颜色
    
}

//在某个point位置画一个点,方便观察运动情况
- (void)drawPoint:(NSArray *)points withContext:(CGContextRef)ctx{
    for (NSValue *pointValue in points) {
        CGPoint point = [pointValue CGPointValue];
        CGContextFillRect(ctx, CGRectMake(point.x - 2, point.y - 2, 4, 4));
    }
}

//重写Progress的set方法.实时改变图片状态
- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    if (progress <= 0.5) {
        self.movePoint = POINT_B;
    }else{
        self.movePoint = POINT_D;
    }
    
    self.lastProgress = progress;
    
    
    // position相当于superLayer中的位置
    CGFloat origin_x = self.position.x - outsideRectSize/2 + (progress - 0.5)*(self.frame.size.width - outsideRectSize);
    CGFloat origin_y = self.position.y - outsideRectSize/2;
    
    self.outsideRect = CGRectMake(origin_x, origin_y, outsideRectSize, outsideRectSize);
    
    [self setNeedsDisplay];
}


@end
