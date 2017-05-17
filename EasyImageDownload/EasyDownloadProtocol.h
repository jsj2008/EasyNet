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

@protocol EasyDownloadProtocol <NSObject>


- (void) easyDownload:(id<EasyImageProtocol>) paras;
- (void) easyCancel:(id<EasyImageProtocol>) paras;

-(void) removeCaches;
-(void) removeCacheForURL:(NSString *) url;

@property (nonatomic, strong) id<EasyQueueProtocol> queueManager;

@property (nonatomic, assign) BOOL memoryCacheMode;
@property (nonatomic, assign) BOOL diskCacheMode;
@property (nonatomic, assign) NSInteger timeoutInterval;

@end


#endif /* EasyDownloadProtocol_h */

