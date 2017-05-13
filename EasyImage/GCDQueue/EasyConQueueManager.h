//
//  EasyConQueueManager.h
//  Images
//
//  Created by wangjufan on 13/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "EasyQueueProtocol.h"

@interface EasyConQueueManager : NSObject<EasyQueueProtocol>

+(nullable instancetype) shareEasyConQueueManager;


@end


