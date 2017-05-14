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



#define EasyBigFileDownload_Queue @"EasyBigFileDownload_Queue"
#define EasyTinyFileDownload_Queue @"EasyTinyFileDownload_Queue"



@protocol EasyImageProtocol;

@protocol EasyDownloadProtocol <NSObject>

- (void) easyDownload:(id<EasyImageProtocol>) paras;
-(void) easyCancelDownload:(id<EasyImageProtocol>) paras;

@property (nonatomic, strong) id<EasyQueueProtocol> queueManager;

@end


#endif /* EasyDownloadProtocol_h */

