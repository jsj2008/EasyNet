//
//  EasyConQueueManager.h
//  Images
//
//  Created by wangjufan on 13/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EasyConQueueManager : NSObject

+(nullable instancetype) shareEasyConQueueManager;

-(BOOL) dispatchBlock:(nonnull dispatch_block_t) block onQueue:(nullable NSString *) key;
-(BOOL) dispatchBarrierBlock:(nonnull dispatch_block_t) block onQueue:(nullable NSString *) key;

-(void) removeBlock:(nonnull dispatch_block_t) block;
-(void) removeQueue:(nullable NSString *) key;
-(void) clearQueue;

@end


