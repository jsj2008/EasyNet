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
#import "EasyImageParaProtocol.h"

#import "EasyLog.h"

@interface EasyTinyFileDownload() 

@property (nonatomic, strong) NSURLSession * urlSession;

@end

@implementation EasyTinyFileDownload

@synthesize queue = _queue;

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

- (void) easyDownload:(id<EasyParaObjectProtocol>) para {
    
    __weak typeof(self) wself = self;
    id<EasyImageParaProtocol> paras = (id<EasyImageParaProtocol>) para;
    
    dispatch_block_t downloadBlock = ^{
        if (paras.hasCanceled) {
            return ;
        }
        
        NSURL * url = [NSURL URLWithString:paras.url];
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
        [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
        
        NSURLSessionDataTask * dataTask = [wself.urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            UIImage * image = [UIImage imageWithData:data];
            
            if (paras.url && !paras.hasCanceled) {
                if (error) {
                    EasyLog(error);
                    if (paras.failedBlock) {
                        paras.failedBlock(error);
                    }
                }else {
                    [data easyDispatchOnMain:^{
                        paras.owner.image = image;

                        if (paras.successBlock) {
                            paras.successBlock();
                        }
                    }];
                }
                if (paras.recycleBlock) {
                    paras.recycleBlock(paras);
                }
            }
        }];
        
        [dataTask resume];
    };
    
    [_queue dispatchBlock:downloadBlock onQueue:EasyTinyFileDownload_Queue];
}


-(void) easyCancelDownload:(id<EasyParaObjectProtocol>) para{
    id<EasyImageParaProtocol> paras = (id<EasyImageParaProtocol>) para;
    if (paras.recycleBlock) {
        paras.recycleBlock(paras);
    }
}


@end

