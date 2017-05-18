//
//  EasyCacheProtocol.h
//  Images
//
//  Created by wangjufan on 12/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#ifndef EasyCacheProtocol_h
#define EasyCacheProtocol_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@protocol EasyCacheProtocol <NSObject>


-(void) clearMemoryCache;
-(void) clearDiskCache;
-(void) shrinkDiskCache;

@optional
- (NSData *) dataForUrl:(NSString *)url;
- (NSData *) dataForUrl:(NSString *)url withLength:(NSInteger) length fromPosition:(long long) position;

-(void) willStartAppendCache:(NSString *) url;
-(void) appendCache:(NSString *) url data:(NSData *) data;

-(void) deletableCache:(NSString *) url data:(NSData *) data;


@end


#endif /* EasyCacheProtocol_h */


