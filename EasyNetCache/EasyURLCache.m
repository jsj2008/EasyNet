//
//  EasyURLCache.m
//  Images
//
//  Created by wangjufan on 17/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import "EasyURLCache.h"

#import "EasyCachePolicy.h"


@implementation EasyURLCache


+(instancetype) easyURLCacheWithMemoryCapacity:(NSUInteger)memoryCapacity diskCapacity:(NSUInteger)diskCapacity diskPath:(nullable NSString *)path{
    return [[self alloc] initWithMemoryCapacity:memoryCapacity diskCapacity:diskCapacity diskPath:path];
}


@end


