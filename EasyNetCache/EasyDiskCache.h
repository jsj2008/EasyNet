//
//  EasyDiskCache.h
//  Images
//
//  Created by wangjufan on 12/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "EasyCacheProtocol.h"
@class EasyCachePolicy;


@interface EasyDiskCache : NSObject<EasyCacheProtocol>

-(instancetype) initWithDirectory:(NSString *) directory NS_DESIGNATED_INITIALIZER;

@end


