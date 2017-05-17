//
//  EasyInnerImageProtocol.h
//  Images
//
//  Created by wangjufan on 14/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#ifndef EasyInnerImageProtocol_h
#define EasyInnerImageProtocol_h


#import "EasyImageProtocol.h"

@protocol EasyInnerImageProtocol <NSObject, EasyImageProtocol>

//@property (atomic, assign) BOOL hasCanceled;
//@property (nonatomic, weak, nullable) UIImageView * owner;
@property (nonatomic, copy, nonnull) void (^ recycledBlock) (id<EasyImageProtocol> _Nullable  para);

@property (nonatomic, weak, nullable) NSURLSessionTask * sessionTask;


@end


#endif /* EasyInnerImageProtocol_h */
