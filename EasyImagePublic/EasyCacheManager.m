//
//  EasyCacheManager.m
//  Images
//
//  Created by wangjufan on 12/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import "EasyCacheManager.h"

#import "EasyLog.h"

#import "EasyTinyFileDownload.h"
#import "EasyBigFileDownload.h"

#import "EasyNonCache.h"
#import "EasyMemoryCache.h"
#import "EasyDiskCache.h"
#import "EasyBothCache.h"


#import "EasyImageParas.h"

#import "EasyConQueueManager.h"
#import "EasySerialQueueManager.h"
#import "EasyConBigFileDownload.h"


#import "EasyURLCacheDownload.h"


#import "EasyURLCachePolicy.h"
#import "EasyUserCachePolicy.h"

@interface EasyCacheManager(){
    NSMutableArray * _easyImageParasCache;
    
    EasyBothCache * _bothCache;
    EasyDiskCache * _diskCache;
    EasyMemoryCache * _memoryCache;
    EasyNonCache * _nonCache;

    EasyTinyFileDownload * _tinyFileDownload;
    EasyBigFileDownload * _bigFileDownload;
    EasyConBigFileDownload * _conbigFileDownload;
    
    EasyURLCacheDownload * _urlCahceDownload;
    
    id<EasyCachePolicyProtocol> _urlCachePolicy;
    id<EasyCachePolicyProtocol> _userCachePolicy;
}

@end

@implementation EasyCacheManager

-(instancetype) init{
    if (self = [super init]) {
        _easyImageParasCache = [NSMutableArray new];
        _easyParasCount = 40;
    }
    return self;
}

/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////

-(id<EasyCachePolicyProtocol>) getURLCachePolicy{
    @synchronized (self) {
        if (_urlCachePolicy == nil) {
            _urlCachePolicy = [EasyURLCachePolicy new];
        }
        return _urlCachePolicy;
    }
}
-(id<EasyCachePolicyProtocol>) getUserCachePolicy{
    @synchronized (self) {
        if (_userCachePolicy == nil) {
            _userCachePolicy = [EasyUserCachePolicy new];
        }
        return _userCachePolicy;
    }
}


/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
-(id<EasyDownloadProtocol>) getTinyFileDownloader{
    @synchronized (self) {
        
        if (_tinyFileDownload == nil) {
            _tinyFileDownload = [EasyTinyFileDownload new];
            _tinyFileDownload.queueManager = [EasyConQueueManager shareEasyQueueManager];
        }
        return _tinyFileDownload;
    }
}
-(id<EasyDownloadProtocol>) getBigFileDownloader{
    @synchronized (self) {
        
        if (_bigFileDownload == nil) {
            _bigFileDownload = [EasyBigFileDownload new];
            _bigFileDownload.queueManager = [EasySerialQueueManager shareEasyQueueManager];
        }
        return _bigFileDownload;
    }
}
-(id<EasyDownloadProtocol>) getConBigFileDownloader{
    @synchronized (self) {
        if (_conbigFileDownload == nil) {
            _conbigFileDownload = [EasyConBigFileDownload new];
            _conbigFileDownload.queueManager = [EasyConQueueManager shareEasyQueueManager];
        }
        return _conbigFileDownload;
    }
}

-(id<EasyDownloadProtocol>) getEasyURLCacheDownloader{
    @synchronized (self) {
        if (_urlCahceDownload == nil) {
            _urlCahceDownload = [EasyURLCacheDownload new];
            _urlCahceDownload.queueManager = [EasyConQueueManager shareEasyQueueManager];
        }
        return _urlCahceDownload;
    }
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
    EasyLog(para);
    return para;
}

-(void) collectEasyImageParas:(EasyImageParas *) para{
    @synchronized (_easyImageParasCache) {
        if ([_easyImageParasCache count] < _easyParasCount) {
            [_easyImageParasCache addObject:para];
#pragma clang diagnostic ignored "-Wundeclared-selector"
            [para performSelector:@selector(reset) withObject:nil];
        }
    }
}

-(void) setEasyParasCount:(NSInteger)easyParasCount{
    _easyParasCount = easyParasCount;
    @synchronized (_easyImageParasCache) {
        if ([_easyImageParasCache count] > _easyParasCount+1) {
            NSRange range = NSMakeRange(_easyParasCount, [_easyImageParasCache count] - _easyParasCount);
            [_easyImageParasCache removeObjectsInRange: range];
        }
    }
}


@end

