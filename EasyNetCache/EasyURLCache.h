//
//  EasyURLCache.h
//  Images
//
//  Created by wangjufan on 17/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import <Foundation/Foundation.h>


#define EasyURLCache_MemoryCache 1024*1024*10
#define EasyURLCache_DiskCache 1024*1024*200
#define EasyURLCache_DefaultPath @"easy.url.image"

@protocol EasyCacheProtocol;


@interface EasyURLCache : NSURLCache<EasyCacheProtocol>

//@property (nonatomic, readonly, strong, nonnull) NSURLCache * urlCache;

//-(instancetype) initWithMemoryCapacity:(NSUInteger)memoryCapacity diskCapacity:(NSUInteger)diskCapacity diskPath:(nullable NSString *)path NS_DESIGNATED_INITIALIZER;

+(instancetype) easyURLCache;

@end


