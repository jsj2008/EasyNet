//
//  EasyURLCacheDownload.m
//  Images
//
//  Created by wangjufan on 17/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import "EasyURLCacheDownload.h"

#import "NSObject+Dispatch.h"
#import "EasyQueueProtocol.h"
#import "EasyInnerImageProtocol.h"

#import "EasyLog.h"

#import "EasyCacheProtocol.h"

#import "EasyCachePolicyProtocol.h"

#import "EasyImageOwnershipProtocol.h"

#import "EasyURLCache.h"

#import "EasyCacheManager.h"

@interface EasyURLCacheDownload()

@property (nonatomic, strong) NSURLSession * urlSession;
@property (nonatomic, strong) NSURLCache * urlCache;

@end

@implementation EasyURLCacheDownload

@synthesize queueManager = _queueManager;
@synthesize timeoutInterval = _timeoutInterval;

@synthesize cachePolicy = _cachePolicy;


-(void) setQueueManager:(id<EasyQueueProtocol>)queueManager{
    _queueManager = queueManager;
}

-(instancetype) init{
    if (self = [super init]) {
        _timeoutInterval = 60;
        
    }
    return self;
}

-(void) setCachePolicy:(id<EasyCachePolicyProtocol>)cachePolicy{
    NSAssert(_cachePolicy == nil, @"_cachePolicy can only be assigned once !");
    _cachePolicy = cachePolicy;
    _urlCache = [EasyURLCache easyURLCacheWithMemoryCapacity:_cachePolicy.memoryCacheSize diskCapacity:_cachePolicy.diskCacheSize diskPath:_cachePolicy.cachePath];
}


-(void) removeCaches{
    [_urlCache removeAllCachedResponses];
}
-(void) removeCacheForURL:(NSString *) urls{
    NSURL * url = [NSURL URLWithString:urls];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    request.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    [_urlCache removeCachedResponseForRequest:request];
}

-(NSURLSession *) urlSession{
    if (_urlSession == nil) {
        @synchronized (self) {
            if (!_urlSession) {
                NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
                configuration.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
                configuration.URLCache = _urlCache;
                _urlSession = [NSURLSession sessionWithConfiguration:configuration
                                                            delegate:nil
                                                       delegateQueue:nil];
            }
        }
    }
    return _urlSession;
}

- (void) easyDownload:(id<EasyImageProtocol>) para {
    __weak typeof(self) wself = self;
    id<EasyInnerImageProtocol> paras = (id<EasyInnerImageProtocol>) para;
    
    dispatch_block_t downloadBlock = ^{
        NSURL * url = [NSURL URLWithString:paras.url];
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
        [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
        request.cachePolicy = NSURLRequestUseProtocolCachePolicy;
        request.timeoutInterval = wself.timeoutInterval;
        
        NSCachedURLResponse * cacheRespones = [_urlCache cachedResponseForRequest:request];
        if (cacheRespones) {
            UIImage * image = [UIImage imageWithData:cacheRespones.data];
            [image easyDispatchOnMain:^{
                paras.owner.image = image;
                if (paras.successBlock) {
                    paras.successBlock(paras);
                }
            }];
            return ;
        }
        NSURLSessionDataTask * dataTask = [wself.urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            UIImage * image = [UIImage imageWithData:data];
            if (paras.url) {
                if (error) {
                    EasyLog(error);
                    if (paras.failedBlock) {
                        paras.failedBlock(paras,error);
                    }
                }else {
                    [data easyDispatchOnMain:^{
                        paras.owner.image = image;
                        if (paras.successBlock) {
                            paras.successBlock(paras);
                        }
                    }];
                }
            }
        }];
        paras.sessionTask = dataTask;
        [dataTask resume];
    };
    [_queueManager dispatchBlock:downloadBlock onQueue:EasyFileDownload_ConQueue];
}

-(void) easyCancel:(id<EasyImageProtocol>) para{
    id<EasyInnerImageProtocol> paras = (id<EasyInnerImageProtocol>) para;
    [paras.sessionTask cancel];
    EasyLog(paras);
    if (paras.cancelBlock) {
        paras.cancelBlock(paras);
    }
}

@end
