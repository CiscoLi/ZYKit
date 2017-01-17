//
//  CircleView.m
//  ZYKit
//
//  Created by zhaoyang on 2017/1/16.
//  Copyright © 2017年 zhaoyang. All rights reserved.
//

#import "CircleView.h"
#import "CircleLayer.h"

@implementation CircleView

+ (Class)layerClass
{
    return [CircleLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.circleLayer = [CircleLayer layer];
        self.circleLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.circleLayer.contentsScale = [UIScreen mainScreen].scale;
        [self.layer addSublayer:self.circleLayer];
    }
    return self;
}

@end
