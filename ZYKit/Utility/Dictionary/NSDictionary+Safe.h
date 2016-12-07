//
//  NSDictionary+Safe.h
//  ZYKit
//
//  Created by zhaoyang on 2016/12/7.
//  Copyright © 2016年 zhaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Safe)

+ (id)dictionaryWithObjectSafe:(id)object forKey:(id<NSCopying>)key;
- (id)objectForKeySafe:(id)aKey;
- (NSString *)stringForKeySafe:(id)akey;
- (NSNumber *)numberForKeySafe:(id)aKey;
- (NSInteger)integerForKeySafe:(id)aKey;
- (long long)longlongForKeySafe:(id)aKey;

- (BOOL)boolForKeySafe:(id)aKey;
- (NSArray *)arrayForKeySafe:(id)aKey;
- (NSDictionary *)dictionaryForKeySafe:(id)aKey;
@end

@interface NSMutableDictionary (Safe)
- (void)setObjectSafe:(id)anObject forKey:(id<NSCopying>)aKey;

@end
