//
//  EasyConQueueManager.m
//  Images
//
//  Created by wangjufan on 13/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import "EasyConQueueManager.h"


static inline BOOL currentQueue(NSString * key){
    if ( dispatch_get_specific([key UTF8String]) ){
        return YES;
    }else {
        return NO;
    }
}

@interface EasyConQueueManager() {
    NSMutableDictionary<NSString *,dispatch_queue_t> * _queueCollection;
}
@end

@implementation EasyConQueueManager

+(instancetype) shareEasyQueueManager{
    static id single = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        single = [EasyConQueueManager new];
    });
    return single;
}

-(instancetype) init{
    if (self = [super init]) {
        _queueCollection = [NSMutableDictionary dictionary];
        dispatch_queue_t gq =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_queue_t disQue = dispatch_queue_create([QueueCon_Default UTF8String], DISPATCH_QUEUE_CONCURRENT);
        dispatch_set_target_queue(disQue, gq);
        
        [_queueCollection setObject:disQue forKey:QueueCon_Default];
    }
    return self;
}

-(BOOL) dispatchBlock:(dispatch_block_t) block onQueue:(NSString *) key{
    if (key) {
        NSAssert([key isEqualToString:EasyFileDownload_ConQueue], @"invalide queue !");
    }
    @synchronized (self) {

        BOOL cqueue = currentQueue(key);
        if (key == nil) {
            key = QueueCon_Default;
        }
        dispatch_queue_t queue = [self queueForKey:key];
        if (queue){
            if (cqueue) {
                block();
            }else{
                dispatch_async(queue, ^{
                    block();
                });
            }
            return YES;
        }
        return NO;
    }
}
-(BOOL) dispatchBarrierBlock:(dispatch_block_t) block onQueue:(NSString *) key{
    if (key) {
        NSAssert([key isEqualToString:EasyFileDownload_ConQueue], @"invalide queue !");
    }
    @synchronized (self) {
        BOOL cqueue = currentQueue(key);
        if (key == nil) {
            key = QueueCon_Default;
        }
        dispatch_queue_t queue = [self queueForKey:key];
        if (queue){
            if (cqueue) {
                block();
            }else{
                dispatch_barrier_async(queue, ^{
                    block();
                });
            }
            return YES;
        }
        return NO;
    }
}

////////////////////////////////////////////////////////
////////////////////////////////////////////////////////

-(void) removeQueue:(NSString *) key{
    if (key) {
        NSAssert([key isEqualToString:EasyFileDownload_ConQueue], @"invalide queue !");
    }
    @synchronized (self) {
        if (key) {
            [_queueCollection removeObjectForKey:key];
        }
    }
}
-(void) clearQueue{
    @synchronized (self) {
        [_queueCollection removeAllObjects];
    }
}
-(const dispatch_queue_t) queueForKey:(NSString *)key{
    if (key) {
        NSAssert([key isEqualToString:EasyFileDownload_ConQueue], @"invalide queue !");
    }
    @synchronized (self) {
        if (key == nil) {
            return [_queueCollection objectForKey:QueueCon_Default];
        }else{
            dispatch_queue_t queue = [_queueCollection objectForKey:key];
            if (queue == nil) {
                dispatch_queue_t gq =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                queue = dispatch_queue_create([key UTF8String], DISPATCH_QUEUE_CONCURRENT);
                dispatch_set_target_queue(queue, gq);
                [_queueCollection setObject:queue forKey:key];
            }
            return [_queueCollection objectForKey:key];
        }
    }
}


@end

