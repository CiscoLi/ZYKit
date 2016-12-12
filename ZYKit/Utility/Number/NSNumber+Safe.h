//
//  NSNumber+Safe.h
//  ZYKit
//
//  Created by zhaoyang on 2016/12/12.
//  Copyright © 2016年 zhaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Safe)
- (char)charValueSafe;
- (unsigned char)unsignedCharValueSafe;
- (short)shortValueSafe;
- (unsigned short)unsignedShortValueSafe;
- (int)intValueSafe;
- (unsigned int)unsignedIntValueSafe;
- (long)longValueSafe;
- (unsigned long)unsignedLongValueSafe;
- (long long)longLongValueSafe;
- (unsigned long long)unsignedLongLongValueSafe;
- (float)floatValueSafe;
- (double)doubleValueSafe;
- (BOOL)boolValueSafe;
- (NSInteger)integerValueSafe;
- (NSUInteger)unsignedIntegerValueSafe;
@end
