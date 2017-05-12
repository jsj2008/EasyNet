//
//  EasyImageParas.m
//  Images
//
//  Created by wangjufan on 12/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import "EasyImageParas.h"

#import "EasyDownloadProtocol.h"
#import "EasyCacheProtocol.h"
#import "EasyTinyFileDownload.h"
#import "EasyCacheManager.h"

@implementation EasyImageParas

-(instancetype) init{
    if (self = [super init]) {
        [self reset];
    }
    return self;
}

-(void) reset{
    _autoCancel = NO;
    _asynLoad = YES;
    _hasCanceled = NO;
    
    _loading = NO;
    
    _url = nil;
    _urlPH = nil;
    
    _downloader = nil;
    _cacher = nil;
    
    _failedBlock = nil;
    _successBlock = nil;
    _recycleBlock = nil;
}

-(void) setRecycleBlock:(void (^)(EasyImageParas *))recycleBlock{
    if (recycleBlock == nil) {
        NSLog(@"---------------");
    }
    _recycleBlock = recycleBlock;
}

-(void) dealloc{
    [self reset];
}

@end
