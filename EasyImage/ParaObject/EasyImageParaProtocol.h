//
//  EasyImageParaProtocol.h
//  Images
//
//  Created by wangjufan on 13/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#ifndef EasyImageParaProtocol_h
#define EasyImageParaProtocol_h

#import "EasyParaObjectProtocol.h"

@protocol EasyImageParaProtocol <NSObject, EasyParaObjectProtocol>

@property (atomic, assign) BOOL hasCanceled;
@property (nonatomic, weak) UIImageView * owner;


@end


#endif /* EasyImageParaProtocol_h */


