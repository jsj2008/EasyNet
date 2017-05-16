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

@interface EasyTinyFileDownload() 

@property (nonatomic, strong) NSURLSession * urlSession;

@end

@implementation EasyTinyFileDownload

@synthesize queueManager = _queueManager;

-(void) setQueueManager:(id<EasyQueueProtocol>)queueManager{
    _queueManager = queueManager;
}

-(NSURLSession *) urlSession{
    if (_urlSession == nil) {
        @synchronized (self) {
            if (!_urlSession) {
                _urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
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
        if (paras.hasCanceled) {
            return ;
        }
        NSURL * url = [NSURL URLWithString:paras.url];
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
        [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
        
        NSURLSessionDataTask * dataTask = [wself.urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            [paras.cacher deletableCache:response.URL.absoluteString data:data];
            UIImage * image = [UIImage imageWithData:data];
            
            if (paras.url && !paras.hasCanceled) {
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
        [dataTask resume];
    };
    
    [_queueManager dispatchBlock:downloadBlock onQueue:EasyFileDownload_ConQueue];
}

-(void) easyCancelDownload:(id<EasyImageProtocol>) para{
    id<EasyInnerImageProtocol> paras = (id<EasyInnerImageProtocol>) para;
    if (paras.failedBlock) {
        paras.failedBlock(paras, nil);
    }
}


@end

