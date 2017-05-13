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

-(BOOL) dispatchBlock:(dispatch_block_t) block onQueue:(NSString *) key;
-(void) removeBlock:(dispatch_block_t) block;

@optional
-(BOOL) dispatchBarrierBlock:(dispatch_block_t) block onQueue:(NSString *) key;
-(void) setMaxQueueSize:(NSInteger) size;

@end


#endif /* EasyQueueProtocol_h */


