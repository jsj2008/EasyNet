//
//  NSObject+Dispatch.m
//  Images
//
//  Created by wangjufan on 14/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import "NSObject+Dispatch.h"

@implementation NSObject(Dispatch)

-(void) easyDispatchOnMain:(dispatch_block_t) block{
    if ([NSThread isMainThread] ) {
        block();
    }else{
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

-(void) easyDispatchOnCon:(dispatch_block_t) block{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        block();
    });
}

@end
