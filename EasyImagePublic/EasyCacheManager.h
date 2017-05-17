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
-(id<EasyDownloadProtocol>) getConBigFileDownloader;

/***********************************************************
   Cache without compress .
   If this downloader was used, the id<EasyCacheProtocol> is useless 
      and you can just leaves it nil in the para object.
 ***********************************************************/
-(id<EasyDownloadProtocol>) getEasyURLCacheDownloader;

//paras
@property (nonatomic, assign) NSInteger easyParasCount;
-(id<EasyImageProtocol>) createEasyImageParas;
-(void) collectEasyImageParas:(id<EasyImageProtocol>) para;


@end

