//
//  EasyURLCachePolicy.m
//  Images
//
//  Created by wangjufan on 18/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import "EasyURLCachePolicy.h"

#define EasyURLCache_Path @"easy.urlcache.path"

#define EasyURLCache_MemorySize 1024*1024*10
#define EasyURLCache_DiskSize 1024*1024*100

@implementation EasyURLCachePolicy

@synthesize cachePath = _cachePath;
@synthesize memoryCacheSize = _memoryCacheSize;
@synthesize diskCacheSize = _diskCacheSize;

-(instancetype) init{
    if (self = [super init]) {
        _memoryCacheSize = EasyURLCache_MemorySize;
        _diskCacheSize = EasyURLCache_DiskSize;
        _cachePath = EasyURLCache_Path;
    }
    return self;
}


-(void) didReceiveMemoryWarning:(NSNotification *) notification{
    
}

-(void) applicationWillTerminate:(NSNotification *) notification{
    
}

-(void) applicationDidEnterBackground:(NSNotification *) notification{
    
}

@end
