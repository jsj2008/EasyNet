//
//  EasyTinyFileDownload.m
//  Images
//
//  Created by wangjufan on 12/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import "EasyTinyFileDownload.h"


#import "NSObject+Dispatch.h"
#import "EasyQueueProtocol.h"
#import "EasyInnerImageProtocol.h"

#import "EasyLog.h"

#import "EasyCacheProtocol.h"

#import "EasyImageOwnershipProtocol.h"


@interface EasyTinyFileDownload() 

@property (nonatomic, strong) NSURLSession * urlSession;


@end

@implementation EasyTinyFileDownload


@synthesize queueManager = _queueManager;
@synthesize timeoutInterval = _timeoutInterval;

-(void) setQueueManager:(id<EasyQueueProtocol>)queueManager{
    _queueManager = queueManager;
}

-(instancetype) init{
    if (self = [super init]) {
        _timeoutInterval = 60;
    }
    return self;
}



-(NSURLSession *) urlSession{
    if (_urlSession == nil) {
        @synchronized (self) {
            if (!_urlSession) {
                NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
                configuration.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
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
        
        NSData * data = [paras.cacher dataForUrl:paras.url];
        if (data) {
            UIImage * image = [UIImage imageWithData:data];
            [data easyDispatchOnMain:^{
                paras.owner.image = image;
                if (paras.successBlock) {
                    paras.successBlock(paras);
                }
            }];
            return ;
        }
        
        NSURL * url = [NSURL URLWithString:paras.url];
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
        [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
        request.cachePolicy = NSURLRequestUseProtocolCachePolicy;
        request.timeoutInterval = wself.timeoutInterval;
 
        NSURLSessionDataTask * dataTask = [wself.urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            [paras.cacher  deletableCache:para.url  data:data];
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

