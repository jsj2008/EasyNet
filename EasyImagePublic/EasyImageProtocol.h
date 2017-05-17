//
//  EasyImageProtocol.h
//  Images
//
//  Created by wangjufan on 14/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#ifndef EasyImageProtocol_h
#define EasyImageProtocol_h


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol EasyDownloadProtocol;
@protocol EasyCacheProtocol;
@protocol EasyImageOwnershipProtocol;



@protocol EasyImageProtocol <NSObject>

@property (nonatomic, weak, nullable) id<EasyImageOwnershipProtocol> owner;  //for example the UIImageView
@property (nonatomic, strong, nullable) UIImage * defaultImage;
@property (nonatomic, assign) BOOL autoCancel;
@property (nonatomic, copy, nonnull) NSString * url;

@property (nonatomic, strong, nullable) id<EasyDownloadProtocol> downloader;
@property (nonatomic, strong, nullable) id<EasyCacheProtocol> cacher;

@property (nonatomic, copy, nonnull) void (^ failedBlock) (id<EasyImageProtocol>_Nullable para,NSError*_Nullable error);
@property (nonatomic, copy, nonnull) void (^ successBlock) (id<EasyImageProtocol> _Nullable  para);
@property (nonatomic, copy, nonnull) void (^ cancelBlock) (id<EasyImageProtocol> _Nullable  para);
@property (nonatomic, copy, nullable) void (^ progressBlock) (float ratio);


@end


#endif /* EasyImageProtocol_h */



