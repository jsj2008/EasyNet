//
//  EasyParaObjectProtocol.h
//  Images
//
//  Created by wangjufan on 13/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#ifndef EasyParaObjectProtocol_h
#define EasyParaObjectProtocol_h


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol EasyDownloadProtocol;
@protocol EasyCacheProtocol;

@protocol EasyParaObjectProtocol <NSObject>

@property (nonatomic, weak) UIImageView * imageView;
@property (nonatomic, copy) NSString * url;
@property (nonatomic, strong) UIImage * defaultImage;

@property (nonatomic, strong) id<EasyDownloadProtocol> downloader;
@property (nonatomic, strong) id<EasyCacheProtocol> cacher;

@property (nonatomic, copy) void (^ failedBlock) (NSError * error);
@property (nonatomic, copy) void (^ recycleBlock) (id<EasyParaObjectProtocol>  para);
@property (nonatomic, copy) void (^ successBlock) ();

@property (nonatomic, assign) BOOL autoCancel;

@end


#endif /* EasyParaObjectProtocol_h */


