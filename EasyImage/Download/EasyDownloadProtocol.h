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



@protocol EasyParaObjectProtocol;

@protocol EasyDownloadProtocol <NSObject>

- (void) easyDownload:(id<EasyParaObjectProtocol>) paras;
-(void) easyCancelDownload:(id<EasyParaObjectProtocol>) paras;

@property (nonatomic, weak) id<EasyQueueProtocol> queue;

@end


#endif /* EasyDownloadProtocol_h */

