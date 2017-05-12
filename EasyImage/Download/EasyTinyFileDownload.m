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


@implementation EasyTinyFileDownload

- (void) easyDownload:(EasyImageParas *) paras{
    
    paras.loading = YES;
    
    [paras easyDispatchOnCon:^{
        if (paras.hasCanceled) {
            NSLog(@"has caceled sysDownload in tiny");
            return ;
        }
        NSLog(@"loding ----------");
     
        NSURL * url = [NSURL URLWithString:paras.url];
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        NSURLSession *session =  [NSURLSession sharedSession];
        
        NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            UIImage * image = [UIImage imageWithData:data];
            paras.recycleBlock(paras);
            [data easyDispatchOnMain:^{
                paras.imageView.image = image;
            }];
            
        }];
        
        [dataTask resume];
    }];
}

-(void) easyCancelDownload:(EasyImageParas *) paras{
    NSLog(@"cancel in tiny");
    paras.hasCanceled = YES;
}


@end

