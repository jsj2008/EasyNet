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

@property (atomic, assign) BOOL hasCanceled;
@property (nonatomic, weak) UIImageView * owner;


@end


#endif /* EasyInnerImageProtocol_h */
