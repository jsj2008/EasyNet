//
//  EasyDownloadProtocol.h
//  Images
//
//  Created by wangjufan on 12/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#ifndef EasyDownloadProtocol_h
#define EasyDownloadProtocol_h


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "EasyQueueProtocol.h"

@protocol EasyImageProtocol;
@protocol EasyCachePolicyProtocol;


@protocol EasyDownloadProtocol <NSObject>

@property (nonatomic, strong) id<EasyQueueProtocol> queueManager;

@property (nonatomic, strong) id<EasyCachePolicyProtocol> cachePolicy;

@property (nonatomic, assign) NSInteger timeoutInterval;
- (void) easyDownload:(id<EasyImageProtocol>) paras;
- (void) easyCancel:(id<EasyImageProtocol>) paras;


@end


#endif /* EasyDownloadProtocol_h */

