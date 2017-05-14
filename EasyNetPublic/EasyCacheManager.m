//
//  EasyCacheManager.m
//  Images
//
//  Created by wangjufan on 12/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import "EasyCacheManager.h"


#import "EasyTinyFileDownload.h"
#import "EasyBigFileDownload.h"

#import "EasyNonCache.h"
#import "EasyMemoryCache.h"
#import "EasyDiskCache.h"
#import "EasyBothCache.h"


#import "EasyImageParas.h"

#import "EasyConQueueManager.h"
#import "EasySerialQueueManager.h"

@interface EasyCacheManager(){
    NSMutableArray * _easyImageParasCache;
    
    EasyBothCache * _bothCache;
    EasyDiskCache * _diskCache;
    EasyMemoryCache * _memoryCache;
    EasyNonCache * _nonCache;
    
    EasyTinyFileDownload * _tinyFileDownload;
    EasyBigFileDownload * _bigFileDownload;
}

@end

@implementation EasyCacheManager

-(instancetype) init{
    if (self = [super init]) {
        _easyImageParasCache = [NSMutableArray new];
        _easyImageParasCount = 40;
    }
    return self;
}

/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
-(void) setMemoryCacheSpaceSizeOfMBits:(NSInteger) size{
    
}
-(void) setDiskCacheSpaceSizeOfMBits:(NSInteger) size{
    
}

/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
-(id<EasyDownloadProtocol>) getTinyFileDownloader{
    if (_tinyFileDownload == nil) {
        _tinyFileDownload = [EasyTinyFileDownload new];
        _tinyFileDownload.queue = [EasyConQueueManager shareEasyQueueManager];
    }
    return _tinyFileDownload;
}
-(id<EasyDownloadProtocol>) getBigFileDownloader{
    if (_bigFileDownload == nil) {
        _bigFileDownload = [EasyBigFileDownload new];
        _bigFileDownload.queue = [EasySerialQueueManager shareEasyQueueManager];
    }
    return _bigFileDownload;
}

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////

-(id<EasyCacheProtocol>) getEasyNonCache{
    if (_nonCache == nil) {
        _nonCache = [EasyNonCache new];
    }
    return _nonCache;
}
-(id<EasyCacheProtocol>) getEasyMemoryCache{
    if (_memoryCache == nil) {
        _memoryCache = [EasyMemoryCache new];
    }
    return _memoryCache;
}
-(id<EasyCacheProtocol>) getEasyDiskCache{
    if (_diskCache == nil) {
        _diskCache = [EasyDiskCache new];
    }
    return _diskCache;
}
-(id<EasyCacheProtocol>) getEasyBontCache{
    if (_bothCache == nil) {
        _bothCache = [EasyBothCache new];
    }
    return _bothCache;
}

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
-(id<EasyImageProtocol>) createEasyImageParas{
    id<EasyImageProtocol> para = nil;
    @synchronized (_easyImageParasCache) {
        para = [_easyImageParasCache lastObject];
        [_easyImageParasCache removeObject:para];
    }
    if (para == nil) {
        para = [[EasyImageParas alloc] init];
    }
    NSLog(@"%@", para);
    return para;
}
-(void) collectEasyImageParas:(EasyImageParas *) para{
    @synchronized (_easyImageParasCache) {
        if ([_easyImageParasCache count] < _easyImageParasCount) {
            [_easyImageParasCache addObject:para];
#pragma clang diagnostic ignored "-Wundeclared-selector"
            [para performSelector:@selector(reset) withObject:nil];
        }
    }
}

-(void) setEasyImageParasCount:(NSInteger)easyImageParasCount{
    _easyImageParasCount = easyImageParasCount;
    @synchronized (_easyImageParasCache) {
        if ([_easyImageParasCache count] > _easyImageParasCount+1) {
            NSRange range = NSMakeRange(_easyImageParasCount, [_easyImageParasCache count] - _easyImageParasCount);
            [_easyImageParasCache removeObjectsInRange: range];
        }
    }
}


@end

