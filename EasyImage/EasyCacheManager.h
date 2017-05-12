//
//  EasyCacheManager.h
//  Images
//
//  Created by wangjufan on 12/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol EasyDownloadProtocol;
@protocol EasyCacheProtocol;
@class EasyImageParas;


@interface EasyCacheManager : NSObject


-(void) setMemoryCacheSpaceSizeOfMBits:(NSInteger) size;
-(void) setDiskCacheSpaceSizeOfMBits:(NSInteger) size;

//cache
-(id<EasyCacheProtocol>) getEasyNonCache;
-(id<EasyCacheProtocol>) getEasyMemoryCache;
-(id<EasyCacheProtocol>) getEasyDiskCache;
-(id<EasyCacheProtocol>) getEasyBontCache;

///down loader
-(id<EasyDownloadProtocol>) getTinyFileDownloader;
-(id<EasyDownloadProtocol>) getBigFileDownloader;

//paras
@property (nonatomic, assign) NSInteger easyImageParasCount;
-(EasyImageParas*) createEasyImageParas;
-(void) collectEasyImageParas:(EasyImageParas *) para;


@end

