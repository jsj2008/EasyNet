//
//  EasyCachePolicyProtocol.h
//  Images
//
//  Created by wangjufan on 18/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#ifndef EasyCachePolicyProtocol_h
#define EasyCachePolicyProtocol_h


@protocol EasyCacheProtocol;


@protocol EasyCachePolicyProtocol <NSObject>

+(NSString *) cacheRootPath;

@property (nonatomic, assign) BOOL memoryCacheMode;
@property (nonatomic, assign) BOOL memoryCacheSize;
@property (nonatomic, assign) long long diskCacheMode;
@property (nonatomic, assign) long long diskCacheSize;

@property (nonatomic, copy, readonly) NSString * cachePath;


-(void) addCacher:(id<EasyCacheProtocol>) cacher;

@end


#endif /* EasyCachePolicyProtocol_h */


