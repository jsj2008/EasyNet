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


@implementation EasyUserCachePolicy

@synthesize cachePath = _cachePath;
@synthesize memoryCacheSize = _memoryCacheSize;
@synthesize diskCacheSize = _diskCacheSize;

-(instancetype) init{
    if (self = [super init]) {
        _memoryCacheSize = EasyUserCache_MemorySize;
        _diskCacheSize = EasyUserCache_DiskSize;
        _cachePath = EasyUserCache_Path;
    }
    return self;
}

+(NSString *) cacheRootPath{
    return EasyUserCache_Path;
}

-(void) didReceiveMemoryWarning:(NSNotification *) notification{
    
}

-(void) applicationWillTerminate:(NSNotification *) notification{
    
}

-(void) applicationDidEnterBackground:(NSNotification *) notification{
    
}

@end

