//
//  EasyQueueProtocol.h
//  Images
//
//  Created by wangjufan on 13/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#ifndef EasyQueueProtocol_h
#define EasyQueueProtocol_h


#define QueueCon_Default @"QueueCon_Default"
#define QueueSerial_Default @"QueueSerial_Default"

#import <Foundation/Foundation.h>


@protocol EasyQueueProtocol <NSObject>
+(nullable instancetype) shareEasyQueueManager;

-(BOOL) dispatchBlock:(nonnull dispatch_block_t) block onQueue:(nullable NSString *) key;

-(void) removeQueue:(nullable NSString *) key;
-(void) clearQueue;

@optional
-(BOOL) dispatchBarrierBlock:(nonnull dispatch_block_t) block onQueue:(nullable NSString *) key;

@end


#endif /* EasyQueueProtocol_h */


