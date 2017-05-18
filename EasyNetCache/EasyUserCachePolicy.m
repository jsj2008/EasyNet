//
//  EasyUserCachePolicy.m
//  Images
//
//  Created by wangjufan on 18/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import "EasyUserCachePolicy.h"

#define EasyUserCache_DiskSize 1024*1024*100
#define EasyUserCache_MemorySize 1024*1024*10
#define EasyUserCache_Path @"/easy.usercache.path"

@interface EasyUserCachePolicy()
@property (nonatomic, strong) NSMutableArray<id<EasyCacheProtocol>> *cachers;
@end

@implementation EasyUserCachePolicy


@synthesize cachePath = _cachePath;
@synthesize memoryCacheSize = _memoryCacheSize;
@synthesize diskCacheSize = _diskCacheSize;

-(instancetype) init{
    if (self = [super init]) {
        _memoryCacheSize = EasyUserCache_MemorySize;
        _diskCacheSize = EasyUserCache_DiskSize;
        _cachePath = EasyUserCache_Path;
        _cachers = [NSMutableArray new];
    }
    return self;
}


-(void) addCacher:(id<EasyCacheProtocol>)cacher{
    @synchronized (_cachers) {
        [_cachers addObject:cacher];
    }
}

+(NSString *) cacheRootPath{
    return EasyUserCache_Path;
}

-(void) didReceiveMemoryWarning:(NSNotification *) notification{
    @synchronized (_cachers) {
        for (id<EasyCacheProtocol> cacher in _cachers) {

        }
    }
}

-(void) applicationWillTerminate:(NSNotification *) notification{
    
}

-(void) applicationDidEnterBackground:(NSNotification *) notification{
    
}

@end

