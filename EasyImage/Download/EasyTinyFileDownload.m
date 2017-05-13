//
//  EasyTinyFileDownload.m
//  Images
//
//  Created by wangjufan on 12/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import "EasyTinyFileDownload.h"

#import "EasyImageParas.h"

#import "NSObject+Dispatch.h"

#import "EasyConQueueManager.h"

#import "EasyImageParaProtocol.h"


@implementation EasyTinyFileDownload

- (void) easyDownload:(id<EasyParaObjectProtocol>) para {
    
    id<EasyImageParaProtocol> paras = (id<EasyImageParaProtocol>) para;
    
    dispatch_block_t downloadBlock = ^{
        if (paras.hasCanceled) {
            return ;
        }
        NSURL * url = [NSURL URLWithString:paras.url];
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        NSURLSession *session =  [NSURLSession sharedSession];
        
        NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (paras.url && !paras.hasCanceled) {
                if (error) {
                    if (paras.failedBlock) {
                        paras.failedBlock(error);
                    }
                }else {
                    UIImage * image = [UIImage imageWithData:data];
                    [data easyDispatchOnMain:^{
                        paras.imageView.image = image;
                    }];
                }
                if (paras.recycleBlock) {
                    paras.recycleBlock(paras);
                }
            }
        }];
        
        [dataTask resume];
        
    };
    paras.cancelBlock = downloadBlock;
    
    [[EasyConQueueManager shareEasyConQueueManager] dispatchBlock:downloadBlock onQueue:@"sdf"];
}


-(void) easyCancelDownload:(id<EasyParaObjectProtocol>) para{
    
    id<EasyImageParaProtocol> paras = (id<EasyImageParaProtocol>) para;
    NSLog(@"cancel in tiny");
//    [[EasyConQueueManager shareEasyConQueueManager] removeBlock:paras.cancelBlock];
}


@end

