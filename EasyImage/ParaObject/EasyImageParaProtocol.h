//
//  EasyImageParaProtocol.h
//  Images
//
//  Created by wangjufan on 13/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#ifndef EasyImageParaProtocol_h
#define EasyImageParaProtocol_h


@protocol EasyParaObjectProtocol;


@protocol EasyImageParaProtocol <NSObject, EasyParaObjectProtocol>

@property (atomic, assign) BOOL hasCanceled;
@property (nonatomic, copy) void (^ cancelBlock) ();

@end


#endif /* EasyImageParaProtocol_h */


