//
//  EasyQueueProtocol.h
//  Images
//
//  Created by wangjufan on 13/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#ifndef EasyQueueProtocol_h
#define EasyQueueProtocol_h


@protocol EasyQueueProtocol <NSObject>

-(BOOL) dispatchBlock:(nonnull dispatch_block_t) block onQueue:(nullable NSString *) key;

//-(void) removeBlock:(nonnull dispatch_block_t) block onQueue:(nullable NSString *) key;
-(void) removeQueue:(nullable NSString *) key;
-(void) clearQueue;

@optional
-(BOOL) dispatchBarrierBlock:(nonnull dispatch_block_t) block onQueue:(nullable NSString *) key;


@end


#endif /* EasyQueueProtocol_h */


