//
//  EasyImageParas.h
//  Images
//
//  Created by wangjufan on 12/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol EasyDownloadProtocol;
@protocol EasyCacheProtocol;

@interface EasyImageParas : NSObject

@property (nonatomic, weak) UIImageView * imageView;
@property (nonatomic, copy) NSString * url;
@property (nonatomic, copy) NSString * urlPH;  //local image name

@property (nonatomic, strong) id<EasyDownloadProtocol> downloader;
@property (nonatomic, strong) id<EasyCacheProtocol> cacher;

@property (nonatomic, copy) void (^ failedBlock) (NSError * error);
@property (nonatomic, copy) void (^ recycleBlock) (EasyImageParas * para);
@property (nonatomic, copy) void (^ successBlock) ();

@property (nonatomic, assign) BOOL autoCancel;
@property (nonatomic, assign) BOOL asynLoad;
@property (nonatomic, assign) BOOL hasCanceled;
@property (atomic, assign) BOOL loading;


@end


