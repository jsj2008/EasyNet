//
//  EasyURLCache.h
//  Images
//
//  Created by wangjufan on 17/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol EasyCacheProtocol;
@class EasyCachePolicy;


@interface EasyURLCache : NSURLCache<EasyCacheProtocol>

//NS_DESIGNATED_INITIALIZER;

+(instancetype) easyURLCacheWithMemoryCapacity:(NSUInteger)memoryCapacity diskCapacity:(NSUInteger)diskCapacity diskPath:(nullable NSString *)path;

@end


