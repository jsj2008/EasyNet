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
@protocol EasyImageProtocol;
@protocol EasyCachePolicyProtocol;


@class EasyCachePolicy;


@interface EasyCacheManager : NSObject


-(const id<EasyCachePolicyProtocol>) getURLCachePolicy;
-(const id<EasyCachePolicyProtocol>) getUserCachePolicy;

//cache
-(const id<EasyCacheProtocol>) getNoneCache;
-(const id<EasyCacheProtocol>) getMemoryCache;
-(const id<EasyCacheProtocol>) getDiskCache;
-(const id<EasyCacheProtocol>) getBothCache;
///down loader
-(const id<EasyDownloadProtocol>) getTinyFileDownloader;
-(const id<EasyDownloadProtocol>) getBigFileDownloader;
-(const id<EasyDownloadProtocol>) getConBigFileDownloader;

/***********************************************************
   Cache without compress .
   If this downloader was used, the id<EasyCacheProtocol> is useless 
      and you can just leaves it nil in the para object.
 ***********************************************************/
-(const id<EasyDownloadProtocol>) getEasyURLCacheDownloader;

//paras
@property (nonatomic, assign) NSInteger easyParasCount;
-(id<EasyImageProtocol>) createEasyImageParas;
-(void) collectEasyImageParas:(id<EasyImageProtocol>) para;


@end

