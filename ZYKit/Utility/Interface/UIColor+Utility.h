//
//  UIColor+Utility.h
//  ZYKit
//
//  Created by zhaoyang on 2016/12/9.
//  Copyright © 2016年 zhaoyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Utility)

+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha;
+ (UIColor *) hexStringToColor: (NSString *) stringToConvert;

@end
