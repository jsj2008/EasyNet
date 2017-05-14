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

- (NSData *) dataForUrl:(NSString *)url;

-(void) startCache:(NSString *) url;
-(void) cache:(NSString *) url data:(NSData *) data;
-(void) finishCache:(NSString *) url;


@end


#endif /* EasyCacheProtocol_h */


