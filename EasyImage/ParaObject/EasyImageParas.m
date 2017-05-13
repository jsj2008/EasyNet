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

@synthesize autoCancel = _autoCancel;
@synthesize hasCanceled = _hasCanceled;

@synthesize downloader = _downloader;
@synthesize cacher = _cacher;

@synthesize url = _url;
@synthesize owner = _owner;
@synthesize defaultImage = _defaultImage;

@synthesize failedBlock = _failedBlock;
@synthesize successBlock = _successBlock;
@synthesize recycleBlock = _recycleBlock;


-(instancetype) init{
    if (self = [super init]) {
        [self reset];
    }
    return self;
}

-(void) reset{
    _autoCancel = NO;
    _hasCanceled = NO;
    
    _url = nil;
    _defaultImage = nil;
    _downloader = nil;
    _cacher = nil;
    
    _failedBlock = nil;
    _successBlock = nil;
    _recycleBlock = nil;
    
}

-(void) setRecycleBlock:(void (^)(id<EasyParaObjectProtocol>))recycleBlock{
    if (recycleBlock == nil) {
        NSLog(@"---------------");
    }
    _recycleBlock = recycleBlock;
}

-(void) dealloc{
    [self reset];
}

@end
