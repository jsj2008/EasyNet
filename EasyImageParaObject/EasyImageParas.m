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
@synthesize downloader = _downloader;
@synthesize cacher = _cacher;

@synthesize url = _url;
@synthesize owner = _owner;
@synthesize defaultImage = _defaultImage;

@synthesize failedBlock = _failedBlock;
@synthesize successBlock = _successBlock;
@synthesize progressBlock = _progressBlock;

@synthesize recycledBlock = _recycledBlock;

@synthesize sessionTask = _sessionTask;

-(instancetype) init{
    if (self = [super init]) {
        [self reset];
    }
    return self;
}

-(void) reset{
    __weak typeof(self) wself = self;
    if (_recycledBlock) {
        _recycledBlock(wself);
    }
    _recycledBlock = nil;
    _autoCancel = NO;
    
    _url = nil;
    _defaultImage = nil;
    _downloader = nil;
    _cacher = nil;
    
    _owner = nil;
    
    _failedBlock = nil;
    _successBlock = nil;
    
}

-(void) dealloc{
    [self reset];
}

@end
