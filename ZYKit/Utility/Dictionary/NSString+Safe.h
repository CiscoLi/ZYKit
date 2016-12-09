//
//  NSString+Safe.h
//  ZYKit
//
//  Created by zhaoyang on 2016/12/9.
//  Copyright © 2016年 zhaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Safe)

- (NSString *)substringFromIndexSafe:(NSUInteger)from;
- (NSString *)substringToIndexSafe:(NSUInteger)to;
- (NSString *)substringWithRangeSafe:(NSRange)range;
- (NSString *)stringByReplacingCharactersInRangeSafe:(NSRange)range withString:(NSString *)replacement;

- (NSString *)stringByAppendingStringSafe:(NSString *)aString;

- (double)doubleValueSafe;
- (float)floatValueSafe;
- (int)intValueSafe;
- (NSInteger)integerValueSafe NS_AVAILABLE(10_5, 2_0);
- (long long)longLongValueSafe NS_AVAILABLE(10_5, 2_0);
- (BOOL)boolValueSafe NS_AVAILABLE(10_5, 2_0);

- (unichar)characterAtIndexSafe:(NSUInteger)index;

@end
