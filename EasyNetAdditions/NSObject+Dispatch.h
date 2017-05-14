//
//  NSObject+Dispatch.h
//  Images
//
//  Created by wangjufan on 14/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject(Dispatch)

-(void) easyDispatchOnMain:(dispatch_block_t) block;
-(void) easyDispatchOnCon:(dispatch_block_t) block;

@end
