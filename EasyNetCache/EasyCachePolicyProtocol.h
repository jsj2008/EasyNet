//
//  EasyCachePolicyProtocol.h
//  Images
//
//  Created by wangjufan on 18/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#ifndef EasyCachePolicyProtocol_h
#define EasyCachePolicyProtocol_h

#define EasyUserCache_Path @"/easy.usercache.path"


#define EasyUserCache_MemorySize 1024*1024*10
#define EasyUserCache_DiskSize 1024*1024*100

@protocol EasyCachePolicyProtocol <NSObject>

@property (nonatomic, assign) BOOL memoryCacheMode;
@property (nonatomic, assign) BOOL memoryCacheSize;

@property (nonatomic, assign) long long diskCacheMode;
@property (nonatomic, assign) long long diskCacheSize;

@property (nonatomic, copy, readonly) NSString * cachePath;

@end


#endif /* EasyCachePolicyProtocol_h */


