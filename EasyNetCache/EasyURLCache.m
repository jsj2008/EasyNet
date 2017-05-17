//
//  EasyURLCache.m
//  Images
//
//  Created by wangjufan on 17/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import "EasyURLCache.h"


@implementation EasyURLCache


+(instancetype) easyURLCache{
    return [[self alloc] initWithMemoryCapacity:EasyURLCache_MemoryCache diskCapacity:EasyURLCache_DiskCache diskPath:EasyURLCache_DefaultPath];
}


//-(instancetype) initWithMemoryCapacity:(NSUInteger)memoryCapacity
//                          diskCapacity:(NSUInteger)diskCapacity
//                              diskPath:(nullable NSString *)path{
//    if (self = [super init]) {
//        _urlCache = [[NSURLCache alloc] initWithMemoryCapacity:memoryCapacity diskCapacity:diskCapacity diskPath:path];
//    }
//    return self;
//}



@end


