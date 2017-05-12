//
//  EasyBigFileDownload.m
//  Images
//
//  Created by wangjufan on 12/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import "EasyBigFileDownload.h"

#import "EasyImageParas.h"

@implementation EasyBigFileDownload


- (void) easyDownload:(EasyImageParas *) paras{
    NSLog(@"load in big");

    if (!paras.asynLoad) {
        NSLog(@"load in big return : para error !");

        return;
    }
    NSLog(@"load in big");
}
-(void) easyCancelDownload:(EasyImageParas *) paras{
    NSLog(@"cancel in big");
    
}


@end


